import 'package:common_state/common_state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

List<Middleware<State>> dashboardMiddleware<State>() => [
      (Store<State> store, dynamic action, NextDispatcher next) {
        if (action is UserSessionStartedAction) {
          store.dispatch(FetchRestaurantsAction());
        }

        next(action);
      },
    ];
