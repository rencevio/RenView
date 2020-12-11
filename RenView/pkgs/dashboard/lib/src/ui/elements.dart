import 'package:flutter/widgets.dart';

import '../style.dart';

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
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 7,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              averageRating == 0 ? '-' : averageRating.toString(),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: Style.averageRatingTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Image.asset(
            'assets/star.png',
            package: 'dashboard',
            height: Style.averageRatingImageSize,
          ),
        ],
      );

  final double averageRating;
}
