import 'package:communicator/communicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:utils/utils.dart';

import '../state.dart';
import '../utils.dart';
import 'elements.dart';
import 'restaurant_details/restaurant_details.dart';

class FilterCriteria {
  FilterCriteria({
    @required this.rating,
  }) : assert(rating >= 0 && rating <= 5);

  final int rating;
}

class RestaurantList extends StatefulWidget {
  const RestaurantList({
    @required this.onRefresh,
    Key key,
  }) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();

  final void Function() onRefresh;
}

class _RestaurantListState extends State<RestaurantList> {
  final _refreshController = RefreshController();

  void _onRefresh() => widget.onRefresh();

  @override
  Widget build(BuildContext context) => Consumer3<Dispatcher, DashboardState, FilterCriteria>(
        builder: (context, dispatcher, state, filerCriteria, _) {
          var firstFetch = false;

          if (_refreshController.isRefresh && !state.refreshingRestaurantList) {
            _refreshController.refreshCompleted();
          } else if (!_refreshController.isRefresh && state.refreshingRestaurantList) {
            firstFetch = true;
          }

          return Stack(
            children: [
              Visibility(
                visible: firstFetch,
                child: const Center(
                  heightFactor: 6,
                  child: CupertinoActivityIndicator(),
                ),
              ),
              Visibility(
                visible: !firstFetch,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView(
                      children: orderRestaurants(state.restaurants, orderCriteria: OrderCriteria.averageRating)
                          .where((r) => r.averageRating >= filerCriteria.rating)
                          .map(
                            (restaurant) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ListTile(
                                title: RestaurantName(restaurant.name),
                                onTap: () {
                                  dispatcher(FetchReviewsForRestaurantAction(restaurantId: restaurant.id));

                                  return Navigator.of(context).push<void>(
                                    MaterialPageRoute(
                                      builder: (context) => RestaurantDetails(restaurantId: restaurant.id),
                                    ),
                                  );
                                },
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 10),
                                  child: RestaurantAddress(restaurant.address),
                                ),
                                trailing: AverageRating(
                                  restaurant.averageRating,
                                  totalReviews: restaurant.totalReviews,
                                ),
                              ),
                            ),
                          )
                          .toList(growable: false),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
}
