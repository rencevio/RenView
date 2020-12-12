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
abstract class $OtherUser {
  const $OtherUser();
  String get id;
  String get name;
  String get role;
  OtherUser copyWith({String id, String name, String role}) => OtherUser(
      id: id ?? this.id, name: name ?? this.name, role: role ?? this.role);
  @override
  String toString() => "OtherUser(id: $id, name: $name, role: $role)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      name == other.name &&
      role == other.role;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + role.hashCode;
    return result;
  }
}

class OtherUser$ {
  static final id =
      Lens<OtherUser, String>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final name = Lens<OtherUser, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final role = Lens<OtherUser, String>(
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
  int get totalReviews;
  Restaurant copyWith(
          {String id,
          String name,
          String address,
          double averageRating,
          int totalReviews}) =>
      Restaurant(
          id: id ?? this.id,
          name: name ?? this.name,
          address: address ?? this.address,
          averageRating: averageRating ?? this.averageRating,
          totalReviews: totalReviews ?? this.totalReviews);
  @override
  String toString() =>
      "Restaurant(id: $id, name: $name, address: $address, averageRating: $averageRating, totalReviews: $totalReviews)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      name == other.name &&
      address == other.address &&
      averageRating == other.averageRating &&
      totalReviews == other.totalReviews;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + address.hashCode;
    result = 37 * result + averageRating.hashCode;
    result = 37 * result + totalReviews.hashCode;
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
  static final totalReviews = Lens<Restaurant, int>((s_) => s_.totalReviews,
      (s_, totalReviews) => s_.copyWith(totalReviews: totalReviews));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $Reviews {
  const $Reviews();
  List<Review> get reviews;
  Reviews copyWith({List<Review> reviews}) =>
      Reviews(reviews: reviews ?? this.reviews);
  @override
  String toString() => "Reviews(reviews: $reviews)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      const DeepCollectionEquality().equals(reviews, other.reviews);
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + const DeepCollectionEquality().hash(reviews);
    return result;
  }
}

class Reviews$ {
  static final reviews = Lens<Reviews, List<Review>>(
      (s_) => s_.reviews, (s_, reviews) => s_.copyWith(reviews: reviews));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $Review {
  const $Review();
  String get id;
  OtherUser get user;
  String get restaurantId;
  int get rating;
  String get visitDate;
  String get comment;
  String get reply;
  Review copyWith(
          {String id,
          OtherUser user,
          String restaurantId,
          int rating,
          String visitDate,
          String comment,
          String reply}) =>
      Review(
          id: id ?? this.id,
          user: user ?? this.user,
          restaurantId: restaurantId ?? this.restaurantId,
          rating: rating ?? this.rating,
          visitDate: visitDate ?? this.visitDate,
          comment: comment ?? this.comment,
          reply: reply ?? this.reply);
  @override
  String toString() =>
      "Review(id: $id, user: $user, restaurantId: $restaurantId, rating: $rating, visitDate: $visitDate, comment: $comment, reply: $reply)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      user == other.user &&
      restaurantId == other.restaurantId &&
      rating == other.rating &&
      visitDate == other.visitDate &&
      comment == other.comment &&
      reply == other.reply;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + user.hashCode;
    result = 37 * result + restaurantId.hashCode;
    result = 37 * result + rating.hashCode;
    result = 37 * result + visitDate.hashCode;
    result = 37 * result + comment.hashCode;
    result = 37 * result + reply.hashCode;
    return result;
  }
}

class Review$ {
  static final id =
      Lens<Review, String>((s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final user = Lens<Review, OtherUser>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
  static final restaurantId = Lens<Review, String>((s_) => s_.restaurantId,
      (s_, restaurantId) => s_.copyWith(restaurantId: restaurantId));
  static final rating = Lens<Review, int>(
      (s_) => s_.rating, (s_, rating) => s_.copyWith(rating: rating));
  static final visitDate = Lens<Review, String>((s_) => s_.visitDate,
      (s_, visitDate) => s_.copyWith(visitDate: visitDate));
  static final comment = Lens<Review, String>(
      (s_) => s_.comment, (s_, comment) => s_.copyWith(comment: comment));
  static final reply = Lens<Review, String>(
      (s_) => s_.reply, (s_, reply) => s_.copyWith(reply: reply));
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

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) {
  return OtherUser(
    id: json['id'] as String,
    name: json['name'] as String,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
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
    totalReviews: json['totalReviews'] as int,
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'averageRating': instance.averageRating,
      'totalReviews': instance.totalReviews,
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) {
  return Reviews(
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'reviews': instance.reviews,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    id: json['id'] as String,
    user: json['user'] == null
        ? null
        : OtherUser.fromJson(json['user'] as Map<String, dynamic>),
    restaurantId: json['restaurant'] as String,
    rating: json['rating'] as int,
    visitDate: json['visitDate'] as String,
    comment: json['comment'] as String,
    reply: json['reply'] as String,
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'restaurant': instance.restaurantId,
      'rating': instance.rating,
      'visitDate': instance.visitDate,
      'comment': instance.comment,
      'reply': instance.reply,
    };
