import 'package:common_state/common_state.dart';
import 'package:communicator/communicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Consumer2<UserIdentity, Dispatcher>(
        builder: (context, user, dispatcher, _) => AlertDialog(
          contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          title: const Text('Change password'),
          actions: [
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState.validate()) {
                  dispatcher(ChangePasswordAction(userId: user.id, newPassword: _newPasswordController.text));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Confirm'),
            ),
          ],
          content: Builder(
            builder: (context) {
              final width = MediaQuery.of(context).size.width;

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    width: width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          autocorrect: false,
                          controller: _newPasswordController,
                          decoration: const InputDecoration(labelText: 'New password'),
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value?.isEmpty ?? true)
                              return 'Field cannot be empty';

                            if (value != _confirmNewPasswordController.text)
                              return 'Passwords do not match';

                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: TextFormField(
                            autocorrect: false,
                            controller: _confirmNewPasswordController,
                            decoration: const InputDecoration(labelText: 'Confirm new password'),
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value?.isEmpty ?? true)
                                return 'Field cannot be empty';

                              if (value != _newPasswordController.text)
                                return 'Passwords do not match';

                              return null;
                            },                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
}
