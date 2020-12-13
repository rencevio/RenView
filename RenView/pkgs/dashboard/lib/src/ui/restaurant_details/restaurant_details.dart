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
import '../dialogs/review_edit_creation_dialog.dart';
import '../dialogs/review_reply_dialog.dart';
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
  Widget build(BuildContext context) => Selector3<Dispatcher, UserIdentity, DashboardState, _ViewModel>(
        selector: (context, dispatcher, userIdentity, state) {
          if (state.restaurants.where((r) => r.id == widget.restaurantId).isEmpty) {
            return lastKnownDetails;
          } else {
            final restaurant = state.restaurants.singleWhere((r) => r.id == widget.restaurantId);

            return _ViewModel(
              dispatcher: dispatcher,
              user: userIdentity,
              restaurant: restaurant,
              reviews: state.reviews.where((r) => r.restaurantId == widget.restaurantId).toList(growable: false),
              isReviewInteractive: (review) =>
                  review.user.id == userIdentity.id || !review.reply.hasValue && restaurant.owner.id == userIdentity.id,
              fetchingReviews: state.refreshingReviewForRestaurants.contains(restaurant.id),
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
                  if (viewModel.user.id == viewModel.restaurant.owner.id)
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
                                  viewModel.dispatcher(
                                      EditRestaurantAction(id: widget.restaurantId, name: name, address: address));
                              },
                            ),
                            onDelete: () => showDialog<void>(
                              context: context,
                              builder: (context) => RestaurantDeletionConfirmationDialog(
                                onDelete: () {
                                  Navigator.of(context).pop();
                                  viewModel.dispatcher(DeleteRestaurantAction(id: widget.restaurantId));
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
                      if (viewModel.canCreateReview)
                        Align(
                          alignment: Alignment.centerRight,
                          child: _CreateReviewButton(
                            dispatcher: viewModel.dispatcher,
                            restaurantId: widget.restaurantId,
                          ),
                        ),
                      const SizedBox(height: 15),
                      if (viewModel.fetchingReviews)
                        const Center(child: CupertinoActivityIndicator())
                      else
                        ReviewList(
                          reviews: viewModel.reviews,
                          isReviewInteractive: viewModel.isReviewInteractive,
                          onReviewTapped: (review) {
                            if (viewModel.user.role == UserRole.user)
                              showReviewEditDialog(
                                context,
                                dispatcher: viewModel.dispatcher,
                                reviewId: review.id,
                                comment: review.comment.valueOr(() => null),
                                rating: review.rating,
                                visitDate: review.visitDate,
                              );
                            else
                              showDialog<void>(
                                context: context,
                                builder: (context) => ReplyToReviewDialog(
                                  reviewId: review.id,
                                ),
                              );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}

@FunctionalData()
class _ViewModel extends $_ViewModel {
  _ViewModel({
    @required this.dispatcher,
    @required this.user,
    @required this.restaurant,
    @required this.isReviewInteractive,
    @required this.fetchingReviews,
    this.reviews,
  });

  bool get canCreateReview => user.role == UserRole.user && !(reviews?.any((r) => r.user.id == user.id) ?? true);

  final Dispatcher dispatcher;
  final UserIdentity user;
  final RestaurantIdentity restaurant;
  final List<ReviewIdentity> reviews;
  final bool Function(ReviewIdentity) isReviewInteractive;
  final bool fetchingReviews;
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

class _CreateReviewButton extends StatelessWidget {
  const _CreateReviewButton({
    @required this.dispatcher,
    @required this.restaurantId,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: () => showReviewCreationDialog(
          context,
          restaurantId: restaurantId,
          dispatcher: dispatcher,
        ),
        child: const Text('Write a review'),
      );

  final Dispatcher dispatcher;
  final String restaurantId;
}
