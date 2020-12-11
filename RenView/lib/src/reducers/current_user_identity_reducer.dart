import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:plain_optional/plain_optional.dart';

Optional<UserIdentity> currentUserIdentityReducer(Optional<UserIdentity> state, dynamic action) {
  if (action is LoginSuccessfulAction) {
    return Optional(action.userIdentity);
  } else if (action is LogoutAction) {
    return const Optional.none();
  }

  return state;
}
