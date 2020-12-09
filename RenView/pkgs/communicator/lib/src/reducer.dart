import 'package:plain_optional/plain_optional.dart';

import '../communicator.dart';

CommunicatorState communicatorReducer(CommunicatorState state, dynamic action) {
  if (action is LoginSuccessfulAction) {
    return state.copyWith(sessionToken: Optional(action.token));
  } else if (action is LoginAction) {
    return state.copyWith(sessionToken: const Optional.none());
  }

  return state;
}
