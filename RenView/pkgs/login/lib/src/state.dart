import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

enum LoginProcess {
  idle,
  registrationSuccessful,
  started,
  failedWrongCredentials,
  failedUnknown,
}

enum RegistrationProcess {
  idle,
  started,
  failed,
}

enum LoginStage {
  login,
  registration,
}

@FunctionalData()
class LoginState extends $LoginState {
  const LoginState({
    @required this.stage,
    @required this.loginProcess,
    @required this.registrationProcess,
  });

  const LoginState.initial()
      : this(
          stage: LoginStage.login,
          loginProcess: LoginProcess.idle,
          registrationProcess: RegistrationProcess.idle,
        );

  final LoginStage stage;
  final LoginProcess loginProcess;
  final RegistrationProcess registrationProcess;
}
