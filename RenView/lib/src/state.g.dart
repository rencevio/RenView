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
  AppState copyWith({CommunicatorState communicatorState}) =>
      AppState(communicatorState: communicatorState ?? this.communicatorState);
  @override
  String toString() => "AppState(communicatorState: $communicatorState)";
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

class AppState$ {
  static final communicatorState = Lens<AppState, CommunicatorState>(
      (s_) => s_.communicatorState,
      (s_, communicatorState) =>
          s_.copyWith(communicatorState: communicatorState));
}
