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
  CommunicatorState get communicatorState;
  LoginState get loginState;
  AppState copyWith(
          {CommunicatorState communicatorState, LoginState loginState}) =>
      AppState(
          communicatorState: communicatorState ?? this.communicatorState,
          loginState: loginState ?? this.loginState);
  @override
  String toString() =>
      "AppState(communicatorState: $communicatorState, loginState: $loginState)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      communicatorState == other.communicatorState &&
      loginState == other.loginState;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + communicatorState.hashCode;
    result = 37 * result + loginState.hashCode;
    return result;
  }
}

class AppState$ {
  static final communicatorState = Lens<AppState, CommunicatorState>(
      (s_) => s_.communicatorState,
      (s_, communicatorState) =>
          s_.copyWith(communicatorState: communicatorState));
  static final loginState = Lens<AppState, LoginState>((s_) => s_.loginState,
      (s_, loginState) => s_.copyWith(loginState: loginState));
}
