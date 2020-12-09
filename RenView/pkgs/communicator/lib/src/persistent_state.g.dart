// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $CommunicatorPersistentState {
  const $CommunicatorPersistentState();
  String get sessionToken;
  CommunicatorPersistentState copyWith({String sessionToken}) =>
      CommunicatorPersistentState(
          sessionToken: sessionToken ?? this.sessionToken);
  @override
  String toString() =>
      "CommunicatorPersistentState(sessionToken: $sessionToken)";
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

class CommunicatorPersistentState$ {
  static final sessionToken = Lens<CommunicatorPersistentState, String>(
      (s_) => s_.sessionToken,
      (s_, sessionToken) => s_.copyWith(sessionToken: sessionToken));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunicatorPersistentState _$CommunicatorPersistentStateFromJson(
    Map<String, dynamic> json) {
  return CommunicatorPersistentState(
    sessionToken: json['sessionToken'] as String,
  );
}

Map<String, dynamic> _$CommunicatorPersistentStateToJson(
        CommunicatorPersistentState instance) =>
    <String, dynamic>{
      'sessionToken': instance.sessionToken,
    };
