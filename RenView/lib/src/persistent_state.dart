import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

import 'state.dart';

part 'persistent_state.g.dart';

// ignore_for_file: annotate_overrides

@JsonSerializable()
@FunctionalData()
class PersistentUserIdentity extends $PersistentUserIdentity {
  PersistentUserIdentity({
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.role,
  });

  PersistentUserIdentity.fromState(UserIdentity state)
      : this(
          id: state.id,
          email: state.email,
          name: state.name,
          role: state.role.toString(),
        );

  UserIdentity toState() => UserIdentity(
        id: id,
        email: email,
        name: name,
        role: UserRole.fromString(role),
      );

  factory PersistentUserIdentity.fromJson(Map<String, dynamic> json) => _$PersistentUserIdentityFromJson(json);

  Map<String, dynamic> toJson() => _$PersistentUserIdentityToJson(this);

  final String id;
  final String email;
  final String name;
  final String role;
}

@JsonSerializable()
@FunctionalData()
class PersistentAppState extends $PersistentAppState {
  const PersistentAppState({
    @required this.currentUserIdentity,
    @required this.communicatorState,
  });

  PersistentAppState.fromState(AppState state)
      : this(
          currentUserIdentity:
              state.currentUserIdentity.map((u) => PersistentUserIdentity.fromState(u)).valueOr(() => null),
          communicatorState: CommunicatorPersistentState.fromState(state.communicatorState),
        );

  AppState toState() => AppState.initial().copyWith(
        currentUserIdentity: Optional(currentUserIdentity).map((u) => u.toState()),
        communicatorState: communicatorState.toState(),
      );

  factory PersistentAppState.fromJson(Map<String, dynamic> json) => _$PersistentAppStateFromJson(json);

  Map<String, dynamic> toJson() => _$PersistentAppStateToJson(this);

  final PersistentUserIdentity currentUserIdentity;
  final CommunicatorPersistentState communicatorState;
}
