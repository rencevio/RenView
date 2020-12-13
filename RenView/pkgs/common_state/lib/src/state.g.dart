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
abstract class $OtherUserIdentity {
  const $OtherUserIdentity();
  String get id;
  String get name;
  UserRole get role;
  OtherUserIdentity copyWith({String id, String name, UserRole role}) =>
      OtherUserIdentity(
          id: id ?? this.id, name: name ?? this.name, role: role ?? this.role);
  @override
  String toString() => "OtherUserIdentity(id: $id, name: $name, role: $role)";
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

class OtherUserIdentity$ {
  static final id = Lens<OtherUserIdentity, String>(
      (s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final name = Lens<OtherUserIdentity, String>(
      (s_) => s_.name, (s_, name) => s_.copyWith(name: name));
  static final role = Lens<OtherUserIdentity, UserRole>(
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
  int get totalReviews;
  OtherUserIdentity get owner;
  RestaurantIdentity copyWith(
          {String id,
          String name,
          String address,
          double averageRating,
          int totalReviews,
          OtherUserIdentity owner}) =>
      RestaurantIdentity(
          id: id ?? this.id,
          name: name ?? this.name,
          address: address ?? this.address,
          averageRating: averageRating ?? this.averageRating,
          totalReviews: totalReviews ?? this.totalReviews,
          owner: owner ?? this.owner);
  @override
  String toString() =>
      "RestaurantIdentity(id: $id, name: $name, address: $address, averageRating: $averageRating, totalReviews: $totalReviews, owner: $owner)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      id == other.id &&
      name == other.name &&
      address == other.address &&
      averageRating == other.averageRating &&
      totalReviews == other.totalReviews &&
      owner == other.owner;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + address.hashCode;
    result = 37 * result + averageRating.hashCode;
    result = 37 * result + totalReviews.hashCode;
    result = 37 * result + owner.hashCode;
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
  static final totalReviews = Lens<RestaurantIdentity, int>(
      (s_) => s_.totalReviews,
      (s_, totalReviews) => s_.copyWith(totalReviews: totalReviews));
  static final owner = Lens<RestaurantIdentity, OtherUserIdentity>(
      (s_) => s_.owner, (s_, owner) => s_.copyWith(owner: owner));
}

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $ReviewIdentity {
  const $ReviewIdentity();
  String get id;
  OtherUserIdentity get user;
  String get restaurantId;
  int get rating;
  DateTime get visitDate;
  Optional<String> get comment;
  Optional<String> get reply;
  ReviewIdentity copyWith(
          {String id,
          OtherUserIdentity user,
          String restaurantId,
          int rating,
          DateTime visitDate,
          Optional<String> comment,
          Optional<String> reply}) =>
      ReviewIdentity(
          id: id ?? this.id,
          user: user ?? this.user,
          restaurantId: restaurantId ?? this.restaurantId,
          rating: rating ?? this.rating,
          visitDate: visitDate ?? this.visitDate,
          comment: comment ?? this.comment,
          reply: reply ?? this.reply);
  @override
  String toString() =>
      "ReviewIdentity(id: $id, user: $user, restaurantId: $restaurantId, rating: $rating, visitDate: $visitDate, comment: $comment, reply: $reply)";
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

class ReviewIdentity$ {
  static final id = Lens<ReviewIdentity, String>(
      (s_) => s_.id, (s_, id) => s_.copyWith(id: id));
  static final user = Lens<ReviewIdentity, OtherUserIdentity>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
  static final restaurantId = Lens<ReviewIdentity, String>(
      (s_) => s_.restaurantId,
      (s_, restaurantId) => s_.copyWith(restaurantId: restaurantId));
  static final rating = Lens<ReviewIdentity, int>(
      (s_) => s_.rating, (s_, rating) => s_.copyWith(rating: rating));
  static final visitDate = Lens<ReviewIdentity, DateTime>((s_) => s_.visitDate,
      (s_, visitDate) => s_.copyWith(visitDate: visitDate));
  static final comment = Lens<ReviewIdentity, Optional<String>>(
      (s_) => s_.comment, (s_, comment) => s_.copyWith(comment: comment));
  static final reply = Lens<ReviewIdentity, Optional<String>>(
      (s_) => s_.reply, (s_, reply) => s_.copyWith(reply: reply));
}
