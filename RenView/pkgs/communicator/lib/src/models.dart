import 'package:collection/collection.dart';
import 'package:common_state/common_state.dart';
import 'package:functional_data/functional_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';

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
class OtherUser extends $OtherUser {
  const OtherUser({
    @required this.id,
    @required this.name,
    @required this.role,
  })  : assert(id != null),
        assert(name != null),
        assert(role != null);

  factory OtherUser.fromJson(Map<String, dynamic> json) => _$OtherUserFromJson(json);

  OtherUserIdentity get identity => OtherUserIdentity(
        id: id,
        name: name,
        role: UserRole.fromString(role),
      );

  final String id;
  final String name;
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
    @required this.totalReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  RestaurantIdentity get identity => RestaurantIdentity(
        id: id,
        name: name,
        address: address,
        averageRating: averageRating,
        totalReviews: totalReviews,
      );

  final String id;
  final String name;
  final String address;
  final double averageRating;
  final int totalReviews;
}

@JsonSerializable()
@FunctionalData()
class Reviews extends $Reviews {
  const Reviews({@required this.reviews});

  factory Reviews.fromJson(List<dynamic> json) => _$ReviewsFromJson(<String, dynamic>{'reviews': json});

  @CustomEquality(DeepCollectionEquality())
  final List<Review> reviews;
}

@JsonSerializable()
@FunctionalData()
class Review extends $Review {
  Review({
    @required this.id,
    @required this.user,
    @required this.restaurantId,
    @required this.rating,
    @required this.visitDate,
    this.comment,
    this.reply,
  })  : assert(id != null),
        assert(user != null),
        assert(restaurantId != null),
        assert(visitDate != null),
        assert(rating != null);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  ReviewIdentity get identity => ReviewIdentity(
        id: id,
        user: user.identity,
        restaurantId: restaurantId,
        rating: rating,
        visitDate: DateTime.parse(visitDate),
        comment: Optional(comment),
        reply: Optional(reply),
      );

  final String id;
  final OtherUser user;
  @JsonKey(name: 'restaurant')
  final String restaurantId;
  final int rating;
  final String visitDate;
  final String comment;
  final String reply;
}
