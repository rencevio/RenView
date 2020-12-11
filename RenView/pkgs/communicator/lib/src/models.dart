import 'package:collection/collection.dart';
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
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

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

  final String id;
  final String name;
  final String address;
  final double averageRating;
}
