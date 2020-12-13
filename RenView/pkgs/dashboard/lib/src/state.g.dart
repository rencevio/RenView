// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $DashboardState {
  const $DashboardState();
  List<RestaurantIdentity> get restaurants;
  List<ReviewIdentity> get reviews;
  bool get refreshingRestaurantList;
  Set<String> get refreshingReviewForRestaurants;
  DashboardState copyWith(
          {List<RestaurantIdentity> restaurants,
          List<ReviewIdentity> reviews,
          bool refreshingRestaurantList,
          Set<String> refreshingReviewForRestaurants}) =>
      DashboardState(
          restaurants: restaurants ?? this.restaurants,
          reviews: reviews ?? this.reviews,
          refreshingRestaurantList:
              refreshingRestaurantList ?? this.refreshingRestaurantList,
          refreshingReviewForRestaurants: refreshingReviewForRestaurants ??
              this.refreshingReviewForRestaurants);
  @override
  String toString() =>
      "DashboardState(restaurants: $restaurants, reviews: $reviews, refreshingRestaurantList: $refreshingRestaurantList, refreshingReviewForRestaurants: $refreshingReviewForRestaurants)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      const DeepCollectionEquality().equals(restaurants, other.restaurants) &&
      const DeepCollectionEquality().equals(reviews, other.reviews) &&
      refreshingRestaurantList == other.refreshingRestaurantList &&
      refreshingReviewForRestaurants == other.refreshingReviewForRestaurants;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + const DeepCollectionEquality().hash(restaurants);
    result = 37 * result + const DeepCollectionEquality().hash(reviews);
    result = 37 * result + refreshingRestaurantList.hashCode;
    result = 37 * result + refreshingReviewForRestaurants.hashCode;
    return result;
  }
}

class DashboardState$ {
  static final restaurants = Lens<DashboardState, List<RestaurantIdentity>>(
      (s_) => s_.restaurants,
      (s_, restaurants) => s_.copyWith(restaurants: restaurants));
  static final reviews = Lens<DashboardState, List<ReviewIdentity>>(
      (s_) => s_.reviews, (s_, reviews) => s_.copyWith(reviews: reviews));
  static final refreshingRestaurantList = Lens<DashboardState, bool>(
      (s_) => s_.refreshingRestaurantList,
      (s_, refreshingRestaurantList) =>
          s_.copyWith(refreshingRestaurantList: refreshingRestaurantList));
  static final refreshingReviewForRestaurants =
      Lens<DashboardState, Set<String>>(
          (s_) => s_.refreshingReviewForRestaurants,
          (s_, refreshingReviewForRestaurants) => s_.copyWith(
              refreshingReviewForRestaurants: refreshingReviewForRestaurants));
}
