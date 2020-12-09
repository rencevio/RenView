// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $PersistentAppState {
  const $PersistentAppState();
  CommunicatorPersistentState get communicatorState;
  PersistentAppState copyWith(
          {CommunicatorPersistentState communicatorState}) =>
      PersistentAppState(
          communicatorState: communicatorState ?? this.communicatorState);
  @override
  String toString() =>
      "PersistentAppState(communicatorState: $communicatorState)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      communicatorState == other.communicatorState;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + communicatorState.hashCode;
    return result;
  }
}

class PersistentAppState$ {
  static final communicatorState =
      Lens<PersistentAppState, CommunicatorPersistentState>(
          (s_) => s_.communicatorState,
          (s_, communicatorState) =>
              s_.copyWith(communicatorState: communicatorState));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistentAppState _$PersistentAppStateFromJson(Map<String, dynamic> json) {
  return PersistentAppState(
    communicatorState: json['communicatorState'] == null
        ? null
        : CommunicatorPersistentState.fromJson(
            json['communicatorState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PersistentAppStateToJson(PersistentAppState instance) =>
    <String, dynamic>{
      'communicatorState': instance.communicatorState,
    };
