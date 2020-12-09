import 'package:communicator/communicator.dart';
import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'state.dart';

part 'persistent_state.g.dart';

// ignore_for_file: annotate_overrides

@JsonSerializable()
@FunctionalData()
class PersistentAppState extends $PersistentAppState {
  const PersistentAppState({@required this.communicatorState});

  PersistentAppState.fromState(AppState state)
      : this(communicatorState: CommunicatorPersistentState.fromState(state.communicatorState));

  AppState toState() => AppState.initial().copyWith(communicatorState: communicatorState.toState());

  factory PersistentAppState.fromJson(Map<String, dynamic> json) =>
      _$PersistentAppStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersistentAppStateToJson(this);

  final CommunicatorPersistentState communicatorState;
}
