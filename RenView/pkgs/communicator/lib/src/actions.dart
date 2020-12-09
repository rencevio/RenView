import 'package:meta/meta.dart';

class LoginAction {
  const LoginAction({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;
}

enum LoginFailureReason {
  wrongCredentials,
  unknown,
}

class LoginFailedAction {
  LoginFailedAction({@required this.reason});

  final LoginFailureReason reason;
}

class LoginSuccessfulAction {
  LoginSuccessfulAction({@required this.token});

  final String token;
}
