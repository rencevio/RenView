import 'package:communicator/communicator.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

List<Middleware<State>> loginMiddleware<State>() => [
      (Store<State> store, dynamic action, NextDispatcher next) {
        if (action is StartLoginAction) {
          store.dispatch(LoginAction(email: action.email, password: action.password));
        } else if (action is StartRegistrationAction) {
          store.dispatch(RegisterAction(
            name: action.name,
            isOwner: action.isOwner,
            email: action.email,
            password: action.password,
          ));
        }

        next(action);
      }
    ];
