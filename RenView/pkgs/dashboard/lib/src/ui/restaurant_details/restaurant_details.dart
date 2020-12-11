import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

import '../../state.dart';
import '../dialogs/restaurant_deletion_confirmation_dialog.dart';
import '../dialogs/restaurant_edit_dialog.dart';
import '../style.dart';
import 'restaurant_details_action_sheet.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({
    @required this.restaurantId,
    Key key,
  }) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();

  final String restaurantId;
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  RestaurantIdentity lastKnownDetails;

  @override
  Widget build(BuildContext context) => Consumer2<Dispatcher, UserIdentity>(
        builder: (context, dispatcher, userIdentity, _) => Selector<DashboardState, RestaurantIdentity>(
          selector: (context, state) {
            if (state.restaurants.where((r) => r.id == widget.restaurantId).isEmpty) {
              return lastKnownDetails;
            } else {
              return state.restaurants.singleWhere((r) => r.id == widget.restaurantId);
            }
          },
          builder: (context, restaurant, _) {
            lastKnownDetails = restaurant;

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(Style.appBarHeight),
                child: AppBar(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(restaurant.name),
                  ),
                  actions: [
                    if (userIdentity.role != UserRole.user)
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (context) => RestaurantDetailsSheet(
                              restaurant: restaurant,
                              onEdit: () => showRestaurantEditDialog(
                                context,
                                name: restaurant.name,
                                address: restaurant.address,
                                onEdit: ({name, address}) {
                                  if (name != null || address != null)
                                    dispatcher(
                                        EditRestaurantAction(id: widget.restaurantId, name: name, address: address));
                                },
                              ),
                              onDelete: () => showDialog<void>(
                                context: context,
                                builder: (context) => RestaurantDeletionConfirmationDialog(
                                  onDelete: () {
                                    Navigator.of(context).pop();
                                    dispatcher(DeleteRestaurantAction(id: widget.restaurantId));
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
              body: Text(restaurant.address),
            );
          },
        ),
      );
}
