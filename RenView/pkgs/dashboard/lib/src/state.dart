import 'package:collection/collection.dart';
import 'package:common_state/common_state.dart';
import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';

part 'state.g.dart';

// ignore_for_file: annotate_overrides

@FunctionalData()
class DashboardState extends $DashboardState {
  const DashboardState({
    @required this.restaurants,
    @required this.reviewsForRestaurant,
    @required this.refreshingRestaurantList,
  });

  const DashboardState.initial()
      : this(
          restaurants: const [],
          reviewsForRestaurant: const {},
          refreshingRestaurantList: false,
        );

  @CustomEquality(DeepCollectionEquality())
  final List<RestaurantIdentity> restaurants;

  @CustomEquality(DeepCollectionEquality())
  final Map<String, List<ReviewIdentity>> reviewsForRestaurant;

  final bool refreshingRestaurantList;
}
