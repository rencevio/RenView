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
  LoginProcess get loginProcess;
  LoginState copyWith({LoginProcess loginProcess}) =>
      LoginState(loginProcess: loginProcess ?? this.loginProcess);
  @override
  String toString() => "LoginState(loginProcess: $loginProcess)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && loginProcess == other.loginProcess;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + loginProcess.hashCode;
    return result;
  }
}

class LoginState$ {
  static final loginProcess = Lens<LoginState, LoginProcess>(
      (s_) => s_.loginProcess,
      (s_, loginProcess) => s_.copyWith(loginProcess: loginProcess));
}
