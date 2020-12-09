import 'package:communicator/communicator.dart';
import 'package:functional_data/functional_data.dart';
import 'package:login/login.dart';
import 'package:meta/meta.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

@FunctionalData()
class AppState extends $AppState {
  const AppState({
    @required this.communicatorState,
    @required this.loginState,
  })  : assert(communicatorState != null),
        assert(loginState != null);

  AppState.initial()
      : this(
          communicatorState: CommunicatorState.initial(),
          loginState: LoginState.initial(),
        );

  final CommunicatorState communicatorState;
  final LoginState loginState;
}
