import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:dashboard/dashboard.dart';
import 'package:functional_data/functional_data.dart';
import 'package:login/login.dart';
import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

@FunctionalData()
class AppState extends $AppState {
  const AppState({
    @required this.currentUserIdentity,
    @required this.communicatorState,
    @required this.loginState,
    @required this.dashboardState,
  })  : assert(currentUserIdentity != null),
        assert(communicatorState != null),
        assert(loginState != null),
        assert(dashboardState != null);

  AppState.initial()
      : this(
          currentUserIdentity: const Optional.none(),
          communicatorState: const CommunicatorState.initial(),
          loginState: const LoginState.initial(),
          dashboardState: const DashboardState.initial(),
        );

  final Optional<UserIdentity> currentUserIdentity;
  final CommunicatorState communicatorState;
  final LoginState loginState;
  final DashboardState dashboardState;
}
