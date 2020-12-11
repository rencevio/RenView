import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dialogs/restaurant_creation_dialog.dart';
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
  Widget build(BuildContext context) => const Text(
        'No pending reviews',
        style: TextStyle(
          fontSize: Style.noPendingReviewsTextSize,
          fontStyle: FontStyle.italic,
        ),
      );
}
