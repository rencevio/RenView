import 'dart:convert';

import 'package:RenView/src/persistent_state.dart';
import 'package:RenView/src/store.dart';
import 'package:communicator/communicator.dart';
import 'package:flutter/material.dart';
import 'package:persistency/persistency.dart';
import 'package:rxdart/rxdart.dart';

import 'src/state.dart';

Future<void> main() async {
  final persistency = Persistency();
  final initialState = await loadAppState(persistency);

  final store = AppStateStore(
    initialState: initialState,
    middleware: [
      ...communicatorMiddleware(),
    ],
  );

  bindPersistencyToStore(persistency, store);

  runApp(MyApp());
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
    final persistedData = persistency.load();
    return persistedData as Map<String, dynamic>;
  } on Exception {
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) => const SizedBox();
}
