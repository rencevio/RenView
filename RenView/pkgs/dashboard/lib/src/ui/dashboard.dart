import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

import 'owner_dashboard.dart';
import 'user_dashboard.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<UserIdentity>(
        builder: (context, userIdentity, _) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: AppBar(
              actions: [
                FlatButton.icon(
                  icon: const Icon(Icons.settings),
                  label: Text(userIdentity.name),
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => _DashboardActionSheet(),
                    );
                  },
                )
              ],
            ),
          ),
          body: SafeArea(
            child: userIdentity.role == UserRole.owner ? OwnerDashboard() : UserDashboard(),
          ),
        ),
      );
}

class _DashboardActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
    builder: (context, dispatcher, _) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
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
