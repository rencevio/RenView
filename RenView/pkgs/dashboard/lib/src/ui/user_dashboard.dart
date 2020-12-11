import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:utils/utils.dart';

import '../actions.dart';
import '../state.dart';
import '../utils.dart';
import 'elements.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final _refreshController = RefreshController();

  void _onRefresh(Dispatcher dispatcher) => dispatcher(FetchRestaurantsAction());

  @override
  Widget build(BuildContext context) => Consumer2<Dispatcher, DashboardState>(
        builder: (context, dispatcher, state, _) {
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
                  padding: const EdgeInsets.all(8.0),
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () => _onRefresh(dispatcher),
                    child: ListView(
                      children: orderRestaurants(state.restaurants, orderCriteria: OrderCriteria.averageRating)
                          .map(
                            (restaurant) => Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListTile(
                                title: RestaurantName(restaurant.name),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 10),
                                  child: RestaurantAddress(restaurant.address),
                                ),
                                trailing: AverageRating(restaurant.averageRating),
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
