// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $PersistentUserIdentity {
  const $PersistentUserIdentity();
  String get id;
  String get email;
  String get name;
  String get role;
  PersistentUserIdentity copyWith(
          {String id, String email, String name, String role}) =>
      PersistentUserIdentity(
          id: id ?? this.id,
          email: email ?? this.email,
          name: name ?? this.name,
          role: role ?? this.role);
  @override
  String toString() =>
      "PersistentUserIdentity(id: $id, email: $email, name: $name, role: $role)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      email == other.email &&
      name == other.name &&
      role == other.role;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + email.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + role.hashCode;
    return result;
  }
}

class PersistentUserIdentity$ {
  static final id = Lens<PersistentUserIdentity, String>(
      (s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final email = Lens<PersistentUserIdentity, String>(
      (s_) => s_.email, (s_, email) => s_.copyWith(email: email));
  static final name = Lens<PersistentUserIdentity, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final role = Lens<PersistentUserIdentity, String>(
      (s_) => s_.role, (s_, role) => s_.copyWith(role: role));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $PersistentAppState {
  const $PersistentAppState();
  PersistentUserIdentity get currentUserIdentity;
  CommunicatorPersistentState get communicatorState;
  PersistentAppState copyWith(
          {PersistentUserIdentity currentUserIdentity,
          CommunicatorPersistentState communicatorState}) =>
      PersistentAppState(
          currentUserIdentity: currentUserIdentity ?? this.currentUserIdentity,
          communicatorState: communicatorState ?? this.communicatorState);
  @override
  String toString() =>
      "PersistentAppState(currentUserIdentity: $currentUserIdentity, communicatorState: $communicatorState)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      currentUserIdentity == other.currentUserIdentity &&
      communicatorState == other.communicatorState;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + currentUserIdentity.hashCode;
    result = 37 * result + communicatorState.hashCode;
    return result;
  }
}

class PersistentAppState$ {
  static final currentUserIdentity =
      Lens<PersistentAppState, PersistentUserIdentity>(
          (s_) => s_.currentUserIdentity,
          (s_, currentUserIdentity) =>
              s_.copyWith(currentUserIdentity: currentUserIdentity));
  static final communicatorState =
      Lens<PersistentAppState, CommunicatorPersistentState>(
          (s_) => s_.communicatorState,
          (s_, communicatorState) =>
              s_.copyWith(communicatorState: communicatorState));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistentUserIdentity _$PersistentUserIdentityFromJson(
    Map<String, dynamic> json) {
  return PersistentUserIdentity(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$PersistentUserIdentityToJson(
        PersistentUserIdentity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'role': instance.role,
    };

PersistentAppState _$PersistentAppStateFromJson(Map<String, dynamic> json) {
  return PersistentAppState(
    currentUserIdentity: json['currentUserIdentity'] == null
        ? null
        : PersistentUserIdentity.fromJson(
            json['currentUserIdentity'] as Map<String, dynamic>),
    communicatorState: json['communicatorState'] == null
        ? null
        : CommunicatorPersistentState.fromJson(
            json['communicatorState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PersistentAppStateToJson(PersistentAppState instance) =>
    <String, dynamic>{
      'currentUserIdentity': instance.currentUserIdentity,
      'communicatorState': instance.communicatorState,
    };
