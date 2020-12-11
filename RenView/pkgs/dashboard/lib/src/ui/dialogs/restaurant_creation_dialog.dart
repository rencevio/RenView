import 'package:communicator/communicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

Future<void> showRestaurantCreationDialog(BuildContext context) => showDialog(
      context: context,
      child: CreateRestaurantDialog(),
    );

class CreateRestaurantDialog extends StatefulWidget {
  @override
  _CreateRestaurantDialogState createState() => _CreateRestaurantDialogState();
}

class _CreateRestaurantDialogState extends State<CreateRestaurantDialog> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
        builder: (context, dispatcher, _) => AlertDialog(
          title: const Text('Create restaurant'),
          actions: [
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState.validate()) {
                  dispatcher(
                    CreateRestaurantAction(
                      name: _nameController.text,
                      address: _addressController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Create'),
            ),
          ],
          content: Builder(
            builder: (context) {
              final width = MediaQuery.of(context).size.width;

              return Form(
                key: _formKey,
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        autocorrect: false,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) => value.isEmpty ? 'Name cannot be empty' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autocorrect: false,
                        controller: _addressController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) => value.isEmpty ? 'Address cannot be empty' : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
}
