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
  RestaurantIdentity get restaurant;
  List<ReviewIdentity> get reviews;
  _ViewModel copyWith(
          {RestaurantIdentity restaurant, List<ReviewIdentity> reviews}) =>
      _ViewModel(
          restaurant: restaurant ?? this.restaurant,
          reviews: reviews ?? this.reviews);
  @override
  String toString() => "_ViewModel(restaurant: $restaurant, reviews: $reviews)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      restaurant == other.restaurant &&
      reviews == other.reviews;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + restaurant.hashCode;
    result = 37 * result + reviews.hashCode;
    return result;
  }
}

class _ViewModel$ {
  static final restaurant = Lens<_ViewModel, RestaurantIdentity>(
      (s_) => s_.restaurant,
      (s_, restaurant) => s_.copyWith(restaurant: restaurant));
  static final reviews = Lens<_ViewModel, List<ReviewIdentity>>(
      (s_) => s_.reviews, (s_, reviews) => s_.copyWith(reviews: reviews));
}
