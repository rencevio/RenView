import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

import 'actions.dart';
import 'state.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isOwner = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
        builder: (context, dispatcher, _) => Consumer<LoginState>(
          builder: (context, loginState, _) {
            final mediaQuery = MediaQuery.of(context);

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: mediaQuery.size.height * 0.25, right: 8.0, left: 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) => value.isEmpty ? 'Name cannot be empty' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) => value.contains('@') ? null : 'Incorrect email',
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Password'),
                        validator: (value) => value.length < 6 ? 'Password must contain at least 6 characters' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        controller: confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Confirm password'),
                        validator: (value) => value != passwordController.text ? 'Passwords do not match' : null,
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        value: isOwner,
                        title: const Text('I am a restaurant owner'),
                        onChanged: (value) => setState(() => isOwner = value),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if (loginState.registrationProcess == RegistrationProcess.started)
                        const CupertinoActivityIndicator()
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  dispatcher(ChangeLoginStageAction(stage: LoginStage.login));
                                },
                                child: const Text('Back'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState.validate()) {
                                    dispatcher(
                                      StartRegistrationAction(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        isOwner: isOwner,
                                      ),
                                    );
                                  }
                                },
                                child: const Text('Register'),
                              ),
                            ),
                          ],
                        ),
                      Visibility(
                        visible: loginState.registrationProcess == RegistrationProcess.failed,
                        child: Column(
                          children: const [
                            SizedBox(height: 10),
                            Text(
                              'Something went wrong, please try again',
                              style: TextStyle(color: Colors.red),
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
