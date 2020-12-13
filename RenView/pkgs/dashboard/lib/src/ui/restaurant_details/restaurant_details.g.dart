// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_details.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $_ViewModel {
  const $_ViewModel();
  Dispatcher get dispatcher;
  UserIdentity get user;
  RestaurantIdentity get restaurant;
  List<ReviewIdentity> get reviews;
  bool Function(ReviewIdentity) get isReviewInteractive;
  _ViewModel copyWith(
          {Dispatcher dispatcher,
          UserIdentity user,
          RestaurantIdentity restaurant,
          List<ReviewIdentity> reviews,
          bool Function(ReviewIdentity) isReviewInteractive}) =>
      _ViewModel(
          dispatcher: dispatcher ?? this.dispatcher,
          user: user ?? this.user,
          restaurant: restaurant ?? this.restaurant,
          reviews: reviews ?? this.reviews,
          isReviewInteractive: isReviewInteractive ?? this.isReviewInteractive);
  @override
  String toString() =>
      "_ViewModel(dispatcher: $dispatcher, user: $user, restaurant: $restaurant, reviews: $reviews, isReviewInteractive: $isReviewInteractive)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      dispatcher == other.dispatcher &&
      user == other.user &&
      restaurant == other.restaurant &&
      reviews == other.reviews &&
      isReviewInteractive == other.isReviewInteractive;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + dispatcher.hashCode;
    result = 37 * result + user.hashCode;
    result = 37 * result + restaurant.hashCode;
    result = 37 * result + reviews.hashCode;
    result = 37 * result + isReviewInteractive.hashCode;
    return result;
  }
}

class _ViewModel$ {
  static final dispatcher = Lens<_ViewModel, Dispatcher>((s_) => s_.dispatcher,
      (s_, dispatcher) => s_.copyWith(dispatcher: dispatcher));
  static final user = Lens<_ViewModel, UserIdentity>(
      (s_) => s_.user, (s_, user) => s_.copyWith(user: user));
  static final restaurant = Lens<_ViewModel, RestaurantIdentity>(
      (s_) => s_.restaurant,
      (s_, restaurant) => s_.copyWith(restaurant: restaurant));
  static final reviews = Lens<_ViewModel, List<ReviewIdentity>>(
      (s_) => s_.reviews, (s_, reviews) => s_.copyWith(reviews: reviews));
  static final isReviewInteractive =
      Lens<_ViewModel, bool Function(ReviewIdentity)>(
          (s_) => s_.isReviewInteractive,
          (s_, isReviewInteractive) =>
              s_.copyWith(isReviewInteractive: isReviewInteractive));
}
