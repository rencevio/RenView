import 'package:communicator/communicator.dart';
import 'package:plain_optional/plain_optional.dart';

import 'actions.dart';
import 'state.dart';

DashboardState dashboardReducer(DashboardState state, dynamic action) {
  if (action is RestaurantsFetchedAction) {
    return state.copyWith(restaurants: action.restaurants, refreshingRestaurantList: false);
  } else if (action is FetchRestaurantsAction) {
    return state.copyWith(refreshingRestaurantList: true);
  } else if (action is RestaurantCreatedAction) {
    return state.copyWith(restaurants: state.restaurants.followedBy([action.restaurant]).toList(growable: false));
  } else if (action is EditRestaurantAction) {
    return state.copyWith(
        restaurants: state.restaurants
            .map((r) => r.id == action.id ? r.copyWith(name: action.name, address: action.address) : r)
            .toList(growable: false));
  } else if (action is DeleteRestaurantAction) {
    return state.copyWith(restaurants: state.restaurants.where((r) => r.id != action.id).toList(growable: false));
  } else if (action is FetchReviewsForRestaurantAction) {
    return state.copyWith(
        refreshingReviewForRestaurants: state.refreshingReviewForRestaurants.toSet()..add(action.restaurantId));
  } else if (action is ReviewsForRestaurantFetchedAction) {
    return state.copyWith(
      reviews: state.reviews
          .where((r) => r.restaurantId != action.restaurantId)
          .followedBy(action.reviews)
          .toList(growable: false),
      refreshingReviewForRestaurants: state.refreshingReviewForRestaurants.toSet()..remove(action.restaurantId),
    );
  } else if (action is ReviewCreatedAction) {
    return state.copyWith(reviews: state.reviews.followedBy([action.review]).toList(growable: false));
  } else if (action is EditReviewAction) {
    return state.copyWith(
        reviews: state.reviews
            .map((r) => r.id == action.reviewId
                ? r.copyWith(rating: action.rating, comment: action.comment, visitDate: action.visitDate)
                : r)
            .toList(growable: false));
  } else if (action is ReplyToReviewAction) {
    return state.copyWith(
        reviews: state.reviews
            .map((r) => r.id == action.reviewId ? r.copyWith(reply: Optional(action.reply)) : r)
            .toList(growable: false));
  }

  return state;
}
