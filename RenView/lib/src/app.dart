import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/login.dart';

class RenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'RenView',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Material(
          child: Login(),
        ),
      );
}
