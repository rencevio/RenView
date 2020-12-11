import 'package:meta/meta.dart';

import 'models.dart';

class LoginResponse {
  LoginResponse({
    @required this.user,
    @required this.token,
  });

  final User user;
  final String token;
}

enum LoginFailureReason {
  wrongCredentials,
  unknown,
}

class LoginException implements Exception {
  LoginException({@required this.reason});

  final LoginFailureReason reason;
}
