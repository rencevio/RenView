// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $AppState {
  const $AppState();
  Optional<UserIdentity> get currentUserIdentity;
  CommunicatorState get communicatorState;
  LoginState get loginState;
  DashboardState get dashboardState;
  AppState copyWith(
          {Optional<UserIdentity> currentUserIdentity,
          CommunicatorState communicatorState,
          LoginState loginState,
          DashboardState dashboardState}) =>
      AppState(
          currentUserIdentity: currentUserIdentity ?? this.currentUserIdentity,
          communicatorState: communicatorState ?? this.communicatorState,
          loginState: loginState ?? this.loginState,
          dashboardState: dashboardState ?? this.dashboardState);
  @override
  String toString() =>
      "AppState(currentUserIdentity: $currentUserIdentity, communicatorState: $communicatorState, loginState: $loginState, dashboardState: $dashboardState)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      currentUserIdentity == other.currentUserIdentity &&
      communicatorState == other.communicatorState &&
      loginState == other.loginState &&
      dashboardState == other.dashboardState;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + currentUserIdentity.hashCode;
    result = 37 * result + communicatorState.hashCode;
    result = 37 * result + loginState.hashCode;
    result = 37 * result + dashboardState.hashCode;
    return result;
  }
}

class AppState$ {
  static final currentUserIdentity = Lens<AppState, Optional<UserIdentity>>(
      (s_) => s_.currentUserIdentity,
      (s_, currentUserIdentity) =>
          s_.copyWith(currentUserIdentity: currentUserIdentity));
  static final communicatorState = Lens<AppState, CommunicatorState>(
      (s_) => s_.communicatorState,
      (s_, communicatorState) =>
          s_.copyWith(communicatorState: communicatorState));
  static final loginState = Lens<AppState, LoginState>((s_) => s_.loginState,
      (s_, loginState) => s_.copyWith(loginState: loginState));
  static final dashboardState = Lens<AppState, DashboardState>(
      (s_) => s_.dashboardState,
      (s_, dashboardState) => s_.copyWith(dashboardState: dashboardState));
}
