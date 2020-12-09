// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $CommunicatorState {
  const $CommunicatorState();
  Optional<String> get sessionToken;
  CommunicatorState copyWith({Optional<String> sessionToken}) =>
      CommunicatorState(sessionToken: sessionToken ?? this.sessionToken);
  @override
  String toString() => "CommunicatorState(sessionToken: $sessionToken)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && sessionToken == other.sessionToken;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + sessionToken.hashCode;
    return result;
  }
}

class CommunicatorState$ {
  static final sessionToken = Lens<CommunicatorState, Optional<String>>(
      (s_) => s_.sessionToken,
      (s_, sessionToken) => s_.copyWith(sessionToken: sessionToken));
}
