import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../utils.dart';
import '../elements.dart';
import '../style.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({
    @required this.reviews,
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
        Review(review: highestAndLowestReviews.key),
        const SizedBox(height: 10),
        const Text(
          'Lowest rated review:',
          style: TextStyle(
            fontSize: 14,
            color: Style.restaurantNameColor,
          ),
        ),
        const SizedBox(height: 5),
        Review(review: highestAndLowestReviews.value),
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
        ..._orderReviews(reviews).getRange(0, Style.restaurantDetailsLastReviewsToDisplay).map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Review(review: r),
            )),
      ],
    );
  }

  final List<ReviewIdentity> reviews;
}

List<ReviewIdentity> _orderReviews(List<ReviewIdentity> reviews) =>
    reviews.toList(growable: false)..sort((r1, r2) => r2.visitDate.compareTo(r1.visitDate));

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
