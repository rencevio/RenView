import 'package:meta/meta.dart';
import 'package:communicator/communicator.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

List<Middleware<State>> loginMiddleware<State>() =>
    [
      (Store<State> store, dynamic action, NextDispatcher next) {
        if (action is StartLoginAction) {
          store.dispatch(LoginAction(username: action.email, password: action.password));
        }

        next(action);
      }
    ];
