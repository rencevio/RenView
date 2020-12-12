import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_data/functional_data.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

import '../../state.dart';
import '../dialogs/restaurant_deletion_confirmation_dialog.dart';
import '../dialogs/restaurant_edit_dialog.dart';
import '../style.dart';
import 'restaurant_details_action_sheet.dart';
import 'review_list.dart';

part 'restaurant_details.g.dart';

// ignore_for_file: annotate_overrides

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
  _ViewModel lastKnownDetails;

  @override
  Widget build(BuildContext context) => Consumer2<Dispatcher, UserIdentity>(
        builder: (context, dispatcher, userIdentity, _) => Selector<DashboardState, _ViewModel>(
          selector: (context, state) {
            if (state.restaurants.where((r) => r.id == widget.restaurantId).isEmpty) {
              return lastKnownDetails;
            } else {
              return _ViewModel(
                restaurant: state.restaurants.singleWhere((r) => r.id == widget.restaurantId),
                reviews: state.reviewsForRestaurant[widget.restaurantId],
              );
            }
          },
          builder: (context, viewModel, _) {
            lastKnownDetails = viewModel;

            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(Style.appBarHeight),
                child: AppBar(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(viewModel.restaurant.name),
                  ),
                  actions: [
                    if (userIdentity.role != UserRole.user)
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (context) => RestaurantDetailsSheet(
                              restaurant: viewModel.restaurant,
                              onEdit: () => showRestaurantEditDialog(
                                context,
                                name: viewModel.restaurant.name,
                                address: viewModel.restaurant.address,
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
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 3),
                                    child: Icon(Icons.location_on),
                                  ),
                                ),
                                TextSpan(
                                  text: viewModel.restaurant.address,
                                  style: const TextStyle(fontSize: Style.restaurantDetailsAddressTextSize),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (viewModel.restaurant.totalReviews > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: _AverageRating(
                              viewModel.restaurant.averageRating,
                              totalReviews: viewModel.restaurant.totalReviews,
                            ),
                          ),
                        const Divider(),
                        const SizedBox(height: 15),
                        if (viewModel.reviews == null)
                          const Center(child: CupertinoActivityIndicator())
                        else
                          ReviewList(reviews: viewModel.reviews),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
}

@FunctionalData()
class _ViewModel extends $_ViewModel {
  _ViewModel({
    @required this.restaurant,
    this.reviews,
  });

  final RestaurantIdentity restaurant;
  final List<ReviewIdentity> reviews;
}

class _AverageRating extends StatelessWidget {
  const _AverageRating(
    this.averageRating, {
    @required this.totalReviews,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 5),
    child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 3,
          children: [
            Image.asset(
              'assets/star.png',
              package: 'dashboard',
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: Style.averageRatingTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' ($totalReviews)',
                      style: const TextStyle(fontSize: Style.averageRatingTotalReviewsTextSize),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
  );

  final double averageRating;
  final int totalReviews;
}
