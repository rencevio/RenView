import 'package:common_state/common_state.dart';
import 'package:meta/meta.dart';

enum OrderCriteria {
  averageRating,
}

List<RestaurantIdentity> orderRestaurants(
  List<RestaurantIdentity> restaurants, {
  @required OrderCriteria orderCriteria,
}) =>
    () {
      switch (orderCriteria) {
        case OrderCriteria.averageRating:
          return restaurants.toList(growable: true)..sort((r1, r2) => r1.name.compareTo(r2.name))..sort((r1, r2) => r2.averageRating.compareTo(r1.averageRating));
      }
    }();
