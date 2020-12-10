import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

import 'actions.dart';
import 'state.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
        builder: (context, dispatcher, _) => Consumer<LoginState>(
          builder: (context, loginState, _) {
            final mediaQuery = MediaQuery.of(context);

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: mediaQuery.size.height * 0.3, right: 8.0, left: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value.contains('@') ? null : 'Incorrect email',
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Password'),
                        validator: (value) => value.isEmpty ? 'Password cannot be empty' : null,
                      ),
                      const SizedBox(height: 20),
                      if (loginState.loginProcess == LoginProcess.started)
                        const CupertinoActivityIndicator()
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  dispatcher(ChangeLoginStageAction(stage: LoginStage.registration));
                                },
                                child: const Text('Register'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState.validate()) {
                                    dispatcher(
                                      StartLoginAction(
                                        email: nameController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Login'),
                              ),
                            ),
                          ],
                        ),
                      Visibility(
                        visible: loginState.loginProcess == LoginProcess.failedWrongCredentials ||
                            loginState.loginProcess == LoginProcess.failedUnknown,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              loginState.loginProcess == LoginProcess.failedWrongCredentials
                                  ? 'Incorrect email or password.'
                                  : 'Something went wrong, please try again',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: loginState.loginProcess == LoginProcess.registrationSuccessful,
                        child: Column(
                          children: const [
                            SizedBox(height: 10),
                            Text(
                              'Registration successful, you can now log in.',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
