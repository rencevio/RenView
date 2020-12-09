import 'package:meta/meta.dart';

class StartLoginAction {
  const StartLoginAction({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;
}
