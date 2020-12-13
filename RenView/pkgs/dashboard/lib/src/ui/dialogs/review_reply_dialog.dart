import 'package:communicator/communicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

class ReplyToReviewDialog extends StatefulWidget {
  const ReplyToReviewDialog({
    @required this.reviewId,
    Key key,
  }) : super(key: key);

  @override
  _ReplyToReviewDialogState createState() => _ReplyToReviewDialogState();

  final String reviewId;
}

class _ReplyToReviewDialogState extends State<ReplyToReviewDialog> {
  final _replyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
        builder: (context, dispatcher, _) => AlertDialog(
          title: const Text('Reply to review'),
          actions: [
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState.validate()) {
                  dispatcher(
                    ReplyToReviewAction(
                      reviewId: widget.reviewId,
                      reply: _replyController.text,
                    ),
                  );

                  Navigator.of(context).pop(true);
                }
              },
              child: const Text('Reply'),
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
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: TextFormField(
                          maxLines: null,
                          autocorrect: false,
                          controller: _replyController,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Reply',
                            hintText: 'Enter your reply here',
                            prefixIcon: Icon(Icons.create),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Reply cannot be empty';
                            }
                            if (value.length > 200) {
                              return 'Reply cannot exceed 200 characters';
                            }
                            return null;
                          },
                        ),
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
