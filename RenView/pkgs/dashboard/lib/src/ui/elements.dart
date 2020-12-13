import 'package:common_state/common_state.dart';
import 'package:flutter/widgets.dart';
import 'package:utils/utils.dart';

import 'style.dart';

class RestaurantName extends StatelessWidget {
  const RestaurantName(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
        color: Style.restaurantNameColor,
        fontSize: Style.restaurantNameSize,
      ));

  final String text;
}

class RestaurantAddress extends StatelessWidget {
  const RestaurantAddress(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
        color: Style.restaurantAddressColor,
        fontSize: Style.restaurantAddressSize,
        fontStyle: FontStyle.italic,
      ));

  final String text;
}

class AverageRating extends StatelessWidget {
  const AverageRating(
    this.averageRating, {
    @required this.totalReviews,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 7,
        children: [
          Wrap(
            direction: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  averageRating == 0 ? '-' : averageRating.toStringAsFixed(1),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: Style.averageRatingTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (totalReviews > 0)
                Text(
                  '($totalReviews)',
                  style: const TextStyle(fontSize: Style.averageRatingTotalReviewsTextSize),
                ),
            ],
          ),
          Image.asset(
            'assets/star.png',
            package: 'dashboard',
            height: Style.averageRatingImageSize,
          ),
        ],
      );

  final double averageRating;
  final int totalReviews;
}

class Review extends StatelessWidget {
  const Review({
    @required this.review,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  for (var i = 0; i < review.rating; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Image.asset(
                        'assets/star.png',
                        package: 'dashboard',
                        height: Style.restaurantDetailsRatingIconSize,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            if (review.comment.hasValue) ...[
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      _reviewerNameTextSpan(review.user.name),
                      const TextSpan(text: 'about his visit on '),
                      _reviewDateTextSpan(review.visitDate.yearMonthDay),
                      const TextSpan(text: ':'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  review.comment.unsafe,
                  style: const TextStyle(fontSize: Style.restaurantDetailsCommentTextSize),
                ),
              ),
              if (review.reply.hasValue) ...[
                const SizedBox(height: 7),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    '''Owner's reply:''',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    review.reply.unsafe,
                    style: const TextStyle(fontSize: Style.restaurantDetailsCommentTextSize),
                  ),
                ),
              ],
            ] else
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      _reviewerNameTextSpan(review.user.name),
                      const TextSpan(text: 'visited on '),
                      _reviewDateTextSpan(review.visitDate.yearMonthDay),
                    ],
                  ),
                ),
              ),
          ],
        ),
  );

  final ReviewIdentity review;
  final void Function() onTap;
}

TextSpan _reviewerNameTextSpan(String name) => TextSpan(
      text: '$name ',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );

TextSpan _reviewDateTextSpan(String date) => TextSpan(
      text: '$date',
      style: const TextStyle(fontStyle: FontStyle.italic),
    );
