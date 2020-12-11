import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:persistency/persistency.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

import 'src/app.dart';
import 'src/middleware.dart';
import 'src/persistent_state.dart';
import 'src/state.dart';
import 'src/store.dart';

class Dependencies {
  AppStateStore store;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dependencies = Dependencies();

  final persistency = Persistency();
  final initialState = await loadAppState(persistency);

  final communicator = Communicator(getSessionToken: () => dependencies.store.state.communicatorState.sessionToken);
  final dispatcher = Dispatcher((dynamic action) => dependencies.store.dispatch(action));

  dependencies.store = AppStateStore(
    initialState: initialState,
    middleware: [
      (store, dynamic action, next) {
        print(action);
        next(action);
      },
      ...appMiddleware(),
      ...communicatorMiddleware(communicator: communicator),
      ...loginMiddleware(),
      ...dashboardMiddleware(),
    ],
  );

  bindPersistencyToStore(persistency, dependencies.store);

  start(dependencies.store, dispatcher);
}

Future<AppState> loadAppState(Persistency persistency) async {
  final persistedData = await loadPersistedData(persistency);

  if (persistedData.isEmpty) {
    return AppState.initial();
  } else {
    return PersistentAppState.fromJson(persistedData).toState();
  }
}

Future<Map<String, dynamic>> loadPersistedData(Persistency persistency) async {
  try {
    final persistedData = await persistency.load();
    print(persistedData);
    return json.decode(persistedData) as Map<String, dynamic>;
  } on Object {
    return <String, dynamic>{};
  }
}

void bindPersistencyToStore(Persistency persistency, AppStateStore store) => store.onChange
    .throttleTime(const Duration(seconds: 1), trailing: true)
    .map((state) => PersistentAppState.fromState(state))
    .distinct()
    .listen(
      (persistentState) => persistency.save(
        json.encode(persistentState),
      ),
    );

void start(AppStateStore store, Dispatcher dispatcher) {
  if (store.state.currentUserIdentity.hasValue) {
    store.dispatch(UserSessionStartedAction(userIdentity: store.state.currentUserIdentity.unsafe));
  }

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: dispatcher),
        fromStore<AppStage>(store, (state) => state.currentUserIdentity.hasValue ? AppStage.dashboard : AppStage.login),
        fromStore<UserIdentity>(store, (state) => state.currentUserIdentity.valueOr(() => UserIdentity.empty())),
        fromStore<LoginState>(store, (state) => state.loginState),
        fromStore<DashboardState>(store, (state) => state.dashboardState),
      ],
      child: RenView(),
    ),
  );
}

StreamProvider<T> fromStore<T>(AppStateStore store, T Function(AppState) convert) => StreamProvider<T>(
      create: (context) => store.onChange.map(convert).distinct(const DeepCollectionEquality().equals),
      initialData: convert(store.state),
    );
