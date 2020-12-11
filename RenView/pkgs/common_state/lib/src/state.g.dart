// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $UserIdentity {
  const $UserIdentity();
  String get id;
  String get email;
  String get name;
  UserRole get role;
  UserIdentity copyWith(
          {String id, String email, String name, UserRole role}) =>
      UserIdentity(
          id: id ?? this.id,
          email: email ?? this.email,
          name: name ?? this.name,
          role: role ?? this.role);
  @override
  String toString() =>
      "UserIdentity(id: $id, email: $email, name: $name, role: $role)";
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

class UserIdentity$ {
  static final id = Lens<UserIdentity, String>(
      (s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final email = Lens<UserIdentity, String>(
      (s_) => s_.email, (s_, email) => s_.copyWith(email: email));
  static final name = Lens<UserIdentity, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final role = Lens<UserIdentity, UserRole>(
      (s_) => s_.role, (s_, role) => s_.copyWith(role: role));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $RestaurantIdentity {
  const $RestaurantIdentity();
  String get id;
  String get name;
  String get address;
  double get averageRating;
  RestaurantIdentity copyWith(
          {String id, String name, String address, double averageRating}) =>
      RestaurantIdentity(
          id: id ?? this.id,
          name: name ?? this.name,
          address: address ?? this.address,
          averageRating: averageRating ?? this.averageRating);
  @override
  String toString() =>
      "RestaurantIdentity(id: $id, name: $name, address: $address, averageRating: $averageRating)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      name == other.name &&
      address == other.address &&
      averageRating == other.averageRating;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + address.hashCode;
    result = 37 * result + averageRating.hashCode;
    return result;
  }
}

class RestaurantIdentity$ {
  static final id = Lens<RestaurantIdentity, String>(
      (s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final name = Lens<RestaurantIdentity, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final address = Lens<RestaurantIdentity, String>(
      (s_) => s_.address, (s_, address) => s_.copyWith(address: address));
  static final averageRating = Lens<RestaurantIdentity, double>(
      (s_) => s_.averageRating,
      (s_, averageRating) => s_.copyWith(averageRating: averageRating));
}
