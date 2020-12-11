import 'package:communicator/communicator.dart';
import 'package:dashboard/dashboard.dart';
import 'package:login/login.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import 'reducers/current_user_identity_reducer.dart';
import 'state.dart';

class AppStateStore extends Store<AppState> {
  AppStateStore({
    @required AppState initialState,
    @required List<Middleware<AppState>> middleware,
  }) : super(
          _reducer,
          initialState: initialState,
          middleware: middleware,
        );
}

AppState _reducer(AppState state, dynamic action) => AppState(
      currentUserIdentity: currentUserIdentityReducer(state.currentUserIdentity, action),
      communicatorState: communicatorReducer(state.communicatorState, action),
      loginState: loginReducer(state.loginState, action),
      dashboardState: dashboardReducer(state.dashboardState, action),
    );
