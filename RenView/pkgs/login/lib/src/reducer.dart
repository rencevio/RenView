import 'package:communicator/communicator.dart';

import '../login.dart';
import 'state.dart';

LoginState loginReducer(LoginState state, dynamic action) {
  if (action is StartLoginAction) {
    return state.copyWith(loginProcess: LoginProcess.started);
  } else if (action is LoginFailedAction) {
    switch (action.reason) {
      case LoginFailureReason.wrongCredentials:
        return state.copyWith(loginProcess: LoginProcess.failedWrongCredentials);
        break;
      case LoginFailureReason.unknown:
        return state.copyWith(loginProcess: LoginProcess.failedUnknown);
        break;
    }
  } else if (action is LoginSuccessfulAction) {
    return state.copyWith(loginProcess: LoginProcess.idle);
  }

  return state;
}
