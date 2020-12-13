import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

List<Middleware<State>> dashboardMiddleware<State>() => [
      (Store<State> store, dynamic action, NextDispatcher next) {
        _middleware(store, action);

        next(action);
      },
    ];

Future<void> _middleware<State>(Store<State> store, dynamic action) async {
  if (action is UserSessionStartedAction) {
    store.dispatch(FetchRestaurantsAction());
    if (action.userIdentity.role == UserRole.owner) {
      store.dispatch(FetchPendingReviewsAction());
    }
  }
}
