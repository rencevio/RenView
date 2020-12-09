import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

enum LoginProcess {
  idle,
  started,
  failedWrongCredentials,
  failedUnknown,
}

@FunctionalData()
class LoginState extends $LoginState {
  LoginState({@required this.loginProcess});

  LoginState.initial() : this(loginProcess: LoginProcess.idle);

  final LoginProcess loginProcess;
}
