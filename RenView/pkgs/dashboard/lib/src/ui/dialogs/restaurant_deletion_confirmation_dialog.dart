import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class RestaurantDeletionConfirmationDialog extends StatelessWidget {
  const RestaurantDeletionConfirmationDialog({
    @required this.onDelete,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Remove restaurant'),
        content: const Text('Are you sure you want to remove this restaurant?'),
        contentPadding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        actions: [
          TextButton(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      );

  final void Function() onDelete;
}
