import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

import '../communicator.dart';

List<Middleware<State>> communicatorMiddleware<State>({
  @required Communicator communicator,
}) =>
    [
      (Store<State> store, dynamic action, NextDispatcher next) {
        if (action is LoginAction) {
          communicator.login(
            email: action.email,
            password: action.password,
            onSuccess: (token) => store.dispatch(LoginSuccessfulAction(token: token)),
            onError: (reason) => store.dispatch(LoginFailedAction(reason: reason)),
          );
        } else if (action is RegisterAction) {
          communicator.register(
            name: action.name,
            isOwner: action.isOwner,
            email: action.email,
            password: action.password,
            onSuccess: () => store.dispatch(RegistrationSuccessfulAction()),
            onError: () => store.dispatch(RegistrationFailedAction()),
          );
        }

        next(action);
      },
    ];
