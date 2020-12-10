// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $LoginState {
  const $LoginState();
  LoginStage get stage;
  LoginProcess get loginProcess;
  RegistrationProcess get registrationProcess;
  LoginState copyWith(
          {LoginStage stage,
          LoginProcess loginProcess,
          RegistrationProcess registrationProcess}) =>
      LoginState(
          stage: stage ?? this.stage,
          loginProcess: loginProcess ?? this.loginProcess,
          registrationProcess: registrationProcess ?? this.registrationProcess);
  @override
  String toString() =>
      "LoginState(stage: $stage, loginProcess: $loginProcess, registrationProcess: $registrationProcess)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      stage == other.stage &&
      loginProcess == other.loginProcess &&
      registrationProcess == other.registrationProcess;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + stage.hashCode;
    result = 37 * result + loginProcess.hashCode;
    result = 37 * result + registrationProcess.hashCode;
    return result;
  }
}

class LoginState$ {
  static final stage = Lens<LoginState, LoginStage>(
      (s_) => s_.stage, (s_, stage) => s_.copyWith(stage: stage));
  static final loginProcess = Lens<LoginState, LoginProcess>(
      (s_) => s_.loginProcess,
      (s_, loginProcess) => s_.copyWith(loginProcess: loginProcess));
  static final registrationProcess = Lens<LoginState, RegistrationProcess>(
      (s_) => s_.registrationProcess,
      (s_, registrationProcess) =>
          s_.copyWith(registrationProcess: registrationProcess));
}
