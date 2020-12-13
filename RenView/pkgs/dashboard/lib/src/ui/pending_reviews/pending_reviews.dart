import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../dialogs/review_reply_dialog.dart';
import '../elements.dart';

class PendingReviews extends StatefulWidget {
  const PendingReviews({
    @required this.restaurants,
    @required this.pendingReviews,
    Key key,
  }) : super(key: key);

  @override
  _PendingReviewsState createState() => _PendingReviewsState();

  final List<ReviewIdentity> pendingReviews;
  final List<RestaurantIdentity> restaurants;
}

class _PendingReviewsState extends State<PendingReviews> {
  List<ReviewIdentity> pendingReviews;

  @override
  void initState() {
    super.initState();

    pendingReviews = widget.pendingReviews;
  }

  Map<String, List<ReviewIdentity>> _groupReviewsByRestaurant(List<ReviewIdentity> reviews) {
    final groupedReviews = <String, List<ReviewIdentity>>{};

    reviews.forEach((r) {
      final restaurant = widget.restaurants.singleWhere((rest) => rest.id == r.restaurantId).name;

      if (groupedReviews[restaurant] == null) {
        groupedReviews[restaurant] = [];
      }

      groupedReviews[restaurant].add(r);
    });

    return groupedReviews;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Pending reviews'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _groupReviewsByRestaurant(pendingReviews)
                    .entries
                    .map(
                      (reviewsForRestaurant) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${reviewsForRestaurant.key}:',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...reviewsForRestaurant.value
                              .map(
                                (review) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Review(
                                    review: review,
                                    onTap: () async {
                                      final answered = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => ReplyToReviewDialog(
                                          reviewId: review.id,
                                        ),
                                      );

                                      if (answered ?? false) {
                                        setState(() {
                                          pendingReviews =
                                              pendingReviews.where((r) => r.id != review.id).toList(growable: false);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              )
                              .toList(growable: false),
                          const Divider(),
                        ],
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
        ),
      );
}
