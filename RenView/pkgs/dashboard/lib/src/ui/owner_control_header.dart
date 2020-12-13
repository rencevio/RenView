import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import 'dialogs/restaurant_creation_dialog.dart';
import 'pending_reviews/pending_reviews.dart';
import 'style.dart';

class OwnerControlHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _PendingReviews(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 40),
                child: FloatingActionButton(
                  onPressed: () => showRestaurantCreationDialog(context),
                  backgroundColor: Style.addRestaurantButtonBackgroundColor,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      );
}

class _PendingReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer2<UserIdentity, DashboardState>(
        builder: (context, user, state, _) {
          final ownedRestaurants = state.restaurants.where((r) => r.owner.id == user.id).map((r) => r.id);
          final pendingReviews = state.reviews
              .where((r) => ownedRestaurants.contains(r.restaurantId))
              .where((r) => !r.reply.hasValue)
              .toList(growable: false);

          if (pendingReviews.isEmpty) {
            return const Text(
              'No pending reviews',
              style: TextStyle(
                fontSize: Style.noPendingReviewsTextSize,
                fontStyle: FontStyle.italic,
              ),
            );
          } else {
            final noun = pendingReviews.length == 1 ? 'review' : 'reviews';

            return RaisedButton(
              onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => PendingReviews(
                    pendingReviews: pendingReviews,
                    restaurants: state.restaurants,
                  ),
                ),
              ),
              child: Text(
                '${pendingReviews.length} pending $noun',
                style: const TextStyle(
                  fontSize: Style.pendingReviewsTextSize,
                ),
              ),
            );
          }
        },
      );
}
