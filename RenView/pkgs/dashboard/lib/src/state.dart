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
    @required this.refreshingRestaurantList,
  });

  const DashboardState.initial()
      : this(
          restaurants: const [],
          refreshingRestaurantList: false,
        );

  @CustomEquality(DeepCollectionEquality())
  final List<RestaurantIdentity> restaurants;

  final bool refreshingRestaurantList;
}
