import 'package:meta/meta.dart';
import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:plain_optional/plain_optional.dart';

import 'state.dart';

part 'persistent_state.g.dart';

// ignore_for_file: annotate_overrides

@FunctionalData()
@JsonSerializable()
class CommunicatorPersistentState extends $CommunicatorPersistentState {
  CommunicatorPersistentState({@required this.sessionToken});

  CommunicatorPersistentState.fromState(CommunicatorState state)
      : this(sessionToken: state.sessionToken.valueOr(() => null));

  CommunicatorState toState() => CommunicatorState(sessionToken: Optional(sessionToken));

  factory CommunicatorPersistentState.fromJson(Map<String, dynamic> json) =>
      _$CommunicatorPersistentStateFromJson(json);

  Map<String, dynamic> toJson() => _$CommunicatorPersistentStateToJson(this);

  final String sessionToken;
}
