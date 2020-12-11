import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<int> showFilterDialog(BuildContext context, int initialRating) => showDialog<int>(
      context: context,
      builder: (context) => FilterDialog(initialRating: initialRating),
    );

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    @required this.initialRating,
    Key key,
  }) : super(key: key);

  static const filterOptions = [0, 1, 2, 3, 4, 5];

  @override
  _FilterDialogState createState() => _FilterDialogState();

  final int initialRating;
}

class _FilterDialogState extends State<FilterDialog> {
  int currentRating;

  @override
  void initState() {
    super.initState();

    currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Restaurant rating'),
        contentPadding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(currentRating),
            child: const Text(
              'Apply',
            ),
          ),
        ],
        content: DropdownButton(
          value: FilterDialog.filterOptions[currentRating],
          onChanged: (int value) => setState(
            () => currentRating = value,
          ),
          items: FilterDialog.filterOptions
              .map(
                (o) => DropdownMenuItem<int>(
                  value: o,
                  child: Text(o == 0 ? 'All' : o == 5 ? o.toString() : '$o or more'),
                ),
              )
              .toList(growable: false),
        ),
      );
}
