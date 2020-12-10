import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'registration.dart';
import 'state.dart';
import 'user_login.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<LoginState>(
        builder: (context, state, _) {
          switch (state.stage) {
            case LoginStage.login:
              return UserLogin();
            case LoginStage.registration:
              return Registration();
          }

          assert(false);
          return null;
        },
      );
}
