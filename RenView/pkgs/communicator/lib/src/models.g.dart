// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $User {
  const $User();
  String get id;
  String get name;
  String get email;
  String get role;
  User copyWith({String id, String name, String email, String role}) => User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role);
  @override
  String toString() => "User(id: $id, name: $name, email: $email, role: $role)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      name == other.name &&
      email == other.email &&
      role == other.role;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + email.hashCode;
    result = 37 * result + role.hashCode;
    return result;
  }
}

class User$ {
  static final id =
      Lens<User, String>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final name = Lens<User, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final email = Lens<User, String>(
      (s_) => s_.email, (s_, email) => s_.copyWith(email: email));
  static final role = Lens<User, String>(
      (s_) => s_.role, (s_, role) => s_.copyWith(role: role));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $Restaurants {
  const $Restaurants();
  List<Restaurant> get restaurants;
  Restaurants copyWith({List<Restaurant> restaurants}) =>
      Restaurants(restaurants: restaurants ?? this.restaurants);
  @override
  String toString() => "Restaurants(restaurants: $restaurants)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      const DeepCollectionEquality().equals(restaurants, other.restaurants);
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + const DeepCollectionEquality().hash(restaurants);
    return result;
  }
}

class Restaurants$ {
  static final restaurants = Lens<Restaurants, List<Restaurant>>(
      (s_) => s_.restaurants,
      (s_, restaurants) => s_.copyWith(restaurants: restaurants));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $Restaurant {
  const $Restaurant();
  String get id;
  String get name;
  String get address;
  double get averageRating;
  Restaurant copyWith(
          {String id, String name, String address, double averageRating}) =>
      Restaurant(
          id: id ?? this.id,
          name: name ?? this.name,
          address: address ?? this.address,
          averageRating: averageRating ?? this.averageRating);
  @override
  String toString() =>
      "Restaurant(id: $id, name: $name, address: $address, averageRating: $averageRating)";
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

class Restaurant$ {
  static final id =
      Lens<Restaurant, String>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final name = Lens<Restaurant, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final address = Lens<Restaurant, String>(
      (s_) => s_.address, (s_, address) => s_.copyWith(address: address));
  static final averageRating = Lens<Restaurant, double>(
      (s_) => s_.averageRating,
      (s_, averageRating) => s_.copyWith(averageRating: averageRating));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
    };

Restaurants _$RestaurantsFromJson(Map<String, dynamic> json) {
  return Restaurants(
    restaurants: (json['restaurants'] as List)
        ?.map((e) =>
            e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RestaurantsToJson(Restaurants instance) =>
    <String, dynamic>{
      'restaurants': instance.restaurants,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    averageRating: (json['averageRating'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'averageRating': instance.averageRating,
    };
