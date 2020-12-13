import 'dart:math';

import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../elements.dart';
import '../style.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({
    @required this.reviews,
    @required this.isReviewInteractive,
    @required this.onReviewTapped,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty)
      return const Center(
        child: Text(
          '''This restaurant doesn't have any reviews yet''',
          style: TextStyle(
            fontSize: 17,
            fontStyle: FontStyle.italic,
          ),
        ),
      );

    final highestAndLowestReviews = _getFirstHighestAndLowestRatedReviews(reviews);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Highest rated review:',
          style: TextStyle(
            fontSize: 14,
            color: Style.restaurantNameColor,
          ),
        ),
        const SizedBox(height: 5),
        Review(
          review: highestAndLowestReviews.key,
          onTap: () =>
              isReviewInteractive(highestAndLowestReviews.key) ? onReviewTapped(highestAndLowestReviews.key) : null,
        ),
        const SizedBox(height: 10),
        const Text(
          'Lowest rated review:',
          style: TextStyle(
            fontSize: 14,
            color: Style.restaurantNameColor,
          ),
        ),
        const SizedBox(height: 5),
        Review(
          review: highestAndLowestReviews.value,
          onTap: () =>
              isReviewInteractive(highestAndLowestReviews.value) ? onReviewTapped(highestAndLowestReviews.value) : null,
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        const Text(
          'Last reviews:',
          style: TextStyle(
            fontSize: 14,
            color: Style.restaurantNameColor,
          ),
        ),
        const SizedBox(height: 5),
        ..._orderReviews(reviews).getRangeSafe(0, Style.restaurantDetailsLastReviewsToDisplay).map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Review(
                review: r,
                onTap: () => isReviewInteractive(r) ? onReviewTapped(r) : null,
              ),
            )),
      ],
    );
  }

  final List<ReviewIdentity> reviews;
  final bool Function(ReviewIdentity) isReviewInteractive;
  final void Function(ReviewIdentity) onReviewTapped;
}

List<ReviewIdentity> _orderReviews(List<ReviewIdentity> reviews) =>
    reviews.toList(growable: true)..sort((r1, r2) => r2.visitDate.compareTo(r1.visitDate));

extension on List<ReviewIdentity> {
  List<ReviewIdentity> getRangeSafe(int start, int end) =>
      getRange(0, min(Style.restaurantDetailsLastReviewsToDisplay, length)).toList(growable: false);
}

MapEntry<ReviewIdentity, ReviewIdentity> _getFirstHighestAndLowestRatedReviews(List<ReviewIdentity> reviews) {
  ReviewIdentity highestReview;
  ReviewIdentity lowestReview;

  reviews.forEach((r) {
    if (highestReview == null || r.rating > highestReview.rating) {
      highestReview = r;
    }

    if (lowestReview == null || r.rating < lowestReview.rating) {
      lowestReview = r;
    }
  });

  return MapEntry(highestReview, lowestReview);
}
