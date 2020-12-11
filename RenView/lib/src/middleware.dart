import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:dashboard/dashboard.dart';
import 'package:redux/redux.dart';

import 'state.dart';

List<Middleware<AppState>> appMiddleware() => [
      (Store<AppState> store, dynamic action, NextDispatcher next) {
        if (action is LoginSuccessfulAction) {
          store.dispatch(UserSessionStartedAction(userIdentity: action.userIdentity));
        } else if (action is FetchRestaurantsAction) {
          final currentUser = store.state.currentUserIdentity.valueOr(() => null);
          assert(currentUser != null, '$FetchRestaurantsAction called without active user identity');

          if (currentUser.role == UserRole.owner) {
            store.dispatch(FetchRestaurantsForOwnerAction(ownerId: currentUser.id));
          } else {
            store.dispatch(FetchRestaurantsForUserAction());
          }
        }

        next(action);
      },
    ];
