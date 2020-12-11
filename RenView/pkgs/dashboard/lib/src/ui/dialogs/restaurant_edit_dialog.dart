import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> showRestaurantEditDialog(
  BuildContext context, {
  @required String name,
  @required String address,
  @required void Function({String name, String address}) onEdit,
}) =>
    showDialog(
      context: context,
      child: EditRestaurantDialog(name: name, address: address, onEdit: onEdit),
    );

class EditRestaurantDialog extends StatefulWidget {
  const EditRestaurantDialog({
    @required this.name,
    @required this.address,
    @required this.onEdit,
    Key key,
  }) : super(key: key);

  @override
  _EditRestaurantDialogState createState() => _EditRestaurantDialogState();

  final String name;
  final String address;
  final void Function({String name, String address}) onEdit;
}

class _EditRestaurantDialogState extends State<EditRestaurantDialog> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.name;
    _addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Edit restaurant'),
        actions: [
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();

              if (_formKey.currentState.validate()) {
                Navigator.of(context).pop();
                widget.onEdit(
                  name: _nameController.text == widget.name ? null : _nameController.text,
                  address: _addressController.text == widget.address ? null : _addressController.text,
                );
              }
            },
            child: const Text('Apply'),
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
      );
}
