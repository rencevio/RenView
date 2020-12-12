import 'package:communicator/communicator.dart';

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
  } else if (action is ReviewsForRestaurantFetchedAction) {
    return state.copyWith(
      reviewsForRestaurant: Map.from(state.reviewsForRestaurant)
        ..addEntries(
          [MapEntry(action.restaurantId, action.reviews)],
        ),
    );
  }

  return state;
}
