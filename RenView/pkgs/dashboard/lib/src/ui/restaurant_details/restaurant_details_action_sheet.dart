import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RestaurantDetailsSheet extends StatelessWidget {
  const RestaurantDetailsSheet({
    @required this.restaurant,
    @required this.onDelete,
    @required this.onEdit,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              onEdit();
            },
            child: const Text('Edit restaurant'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            child: const Text('Remove restaurant'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          isDefaultAction: true,
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      );

  final RestaurantIdentity restaurant;
  final void Function() onDelete;
  final void Function() onEdit;
}
