import 'package:meta/meta.dart';

import 'state.dart';

class StartLoginAction {
  const StartLoginAction({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;
}

class ChangeLoginStageAction {
  ChangeLoginStageAction({
    @required this.stage,
  });

  final LoginStage stage;
}

class StartRegistrationAction {
  const StartRegistrationAction({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.isOwner,
  });

  final String name;
  final String email;
  final String password;
  final bool isOwner;
}
