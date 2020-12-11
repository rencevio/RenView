import 'package:communicator/communicator.dart';

import 'actions.dart';
import 'state.dart';

DashboardState dashboardReducer(DashboardState state, dynamic action) {
  if (action is RestaurantsFetchedAction) {
    return state.copyWith(restaurants: action.restaurants, refreshingRestaurantList: false);
  } else if (action is FetchRestaurantsAction) {
    return state.copyWith(refreshingRestaurantList: true);
  }

  return state;
}
