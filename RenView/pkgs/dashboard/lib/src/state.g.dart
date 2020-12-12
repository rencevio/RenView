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
  Map<String, List<ReviewIdentity>> get reviewsForRestaurant;
  bool get refreshingRestaurantList;
  DashboardState copyWith(
          {List<RestaurantIdentity> restaurants,
          Map<String, List<ReviewIdentity>> reviewsForRestaurant,
          bool refreshingRestaurantList}) =>
      DashboardState(
          restaurants: restaurants ?? this.restaurants,
          reviewsForRestaurant:
              reviewsForRestaurant ?? this.reviewsForRestaurant,
          refreshingRestaurantList:
              refreshingRestaurantList ?? this.refreshingRestaurantList);
  @override
  String toString() =>
      "DashboardState(restaurants: $restaurants, reviewsForRestaurant: $reviewsForRestaurant, refreshingRestaurantList: $refreshingRestaurantList)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      const DeepCollectionEquality().equals(restaurants, other.restaurants) &&
      const DeepCollectionEquality()
          .equals(reviewsForRestaurant, other.reviewsForRestaurant) &&
      refreshingRestaurantList == other.refreshingRestaurantList;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + const DeepCollectionEquality().hash(restaurants);
    result =
        37 * result + const DeepCollectionEquality().hash(reviewsForRestaurant);
    result = 37 * result + refreshingRestaurantList.hashCode;
    return result;
  }
}

class DashboardState$ {
  static final restaurants = Lens<DashboardState, List<RestaurantIdentity>>(
      (s_) => s_.restaurants,
      (s_, restaurants) => s_.copyWith(restaurants: restaurants));
  static final reviewsForRestaurant =
      Lens<DashboardState, Map<String, List<ReviewIdentity>>>(
          (s_) => s_.reviewsForRestaurant,
          (s_, reviewsForRestaurant) =>
              s_.copyWith(reviewsForRestaurant: reviewsForRestaurant));
  static final refreshingRestaurantList = Lens<DashboardState, bool>(
      (s_) => s_.refreshingRestaurantList,
      (s_, refreshingRestaurantList) =>
          s_.copyWith(refreshingRestaurantList: refreshingRestaurantList));
}
