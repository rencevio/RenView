import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

import 'dialogs/password_change_dialog.dart';

class DashboardActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
    builder: (context, dispatcher, _) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
            showDialog<void>(context: context, builder: (context) => ChangePasswordDialog());
          },
          child: const Text('Change password'),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            dispatcher(LogoutAction());
            Navigator.of(context).pop();
          },
          child: const Text('Logout'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDestructiveAction: true,
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
    ),
  );
}
