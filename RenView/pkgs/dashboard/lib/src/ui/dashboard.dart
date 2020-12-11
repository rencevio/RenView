import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dashboard_action_sheet.dart';
import 'dialogs/filter_dialog.dart';
import 'owner_control_header.dart';
import 'restaurant_list.dart';
import 'style.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _filterCriteria = FilterCriteria(rating: 0);

  @override
  Widget build(BuildContext context) => Consumer<UserIdentity>(
        builder: (context, userIdentity, _) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(Style.appBarHeight),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () async {
                  final selectedFilter = await showFilterDialog(context, _filterCriteria.rating);

                  if (selectedFilter != _filterCriteria.rating) {
                    setState(() => _filterCriteria = FilterCriteria(rating: selectedFilter));
                  }
                },
              ),
              actions: [
                FlatButton.icon(
                  icon: const Icon(Icons.settings),
                  label: Text(userIdentity.name),
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => DashboardActionSheet(),
                    );
                  },
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Provider.value(
              value: _filterCriteria,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    if (userIdentity.role == UserRole.owner) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: OwnerControlHeader(),
                      ),
                      const Divider(),
                    ],
                    const SizedBox(height: 10),
                    Expanded(child: RestaurantList()),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
