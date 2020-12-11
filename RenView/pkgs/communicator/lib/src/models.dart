import 'package:collection/collection.dart';
import 'package:common_state/common_state.dart';
import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'models.g.dart';

// ignore_for_file: annotate_overrides

@JsonSerializable()
@FunctionalData()
class User extends $User {
  const User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.role,
  })  : assert(id != null),
        assert(name != null),
        assert(email != null),
        assert(role != null);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  UserIdentity get identity => UserIdentity(
        id: id,
        name: name,
        email: email,
        role: UserRole.fromString(role),
      );

  final String id;
  final String name;
  final String email;
  final String role;
}

@JsonSerializable()
@FunctionalData()
class Restaurants extends $Restaurants {
  const Restaurants({@required this.restaurants});

  factory Restaurants.fromJson(List<dynamic> json) => _$RestaurantsFromJson(<String, dynamic>{'restaurants': json});

  @CustomEquality(DeepCollectionEquality())
  final List<Restaurant> restaurants;
}

@JsonSerializable()
@FunctionalData()
class Restaurant extends $Restaurant {
  const Restaurant({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.averageRating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  RestaurantIdentity get identity => RestaurantIdentity(
        id: id,
        name: name,
        address: address,
        averageRating: averageRating,
      );

  final String id;
  final String name;
  final String address;
  final double averageRating;
}
