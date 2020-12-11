import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'owner_dashboard.dart';
import 'user_dashboard.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Consumer<UserIdentity>(
            builder: (context, userIdentity, _) {
              if (userIdentity.role == UserRole.owner) {
                return OwnerDashboard();
              } else {
                return UserDashboard();
              }
            },
          ),
        ),
      );
}
