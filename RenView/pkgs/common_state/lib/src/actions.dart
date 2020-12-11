import 'package:meta/meta.dart';

import '../common_state.dart';

class UserSessionStartedAction {
  UserSessionStartedAction({@required this.userIdentity});

  final UserIdentity userIdentity;
}

class LogoutAction {}
