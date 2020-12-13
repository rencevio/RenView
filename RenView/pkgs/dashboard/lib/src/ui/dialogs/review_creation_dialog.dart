import 'package:communicator/communicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plain_optional/plain_optional.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

Future<void> showReviewCreationDialog(
  BuildContext context, {
  @required String restaurantId,
}) =>
    showDialog(
      context: context,
      child: CreateReviewDialog(
        restaurantId: restaurantId,
      ),
    );

class CreateReviewDialog extends StatefulWidget {
  const CreateReviewDialog({
    @required this.restaurantId,
    Key key,
  }) : super(key: key);

  @override
  _CreateReviewDialogState createState() => _CreateReviewDialogState();

  final String restaurantId;
}

class _CreateReviewDialogState extends State<CreateReviewDialog> {
  final _commentController = TextEditingController();
  DateTime visitDate;

  final _formKey = GlobalKey<FormState>();
  final _formDateKey = GlobalKey<_DateFormFieldState>();
  final _formRatingKey = GlobalKey<_RatingFormFieldState>();

  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
        builder: (context, dispatcher, _) => AlertDialog(
          contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          title: const Text('Create a review'),
          actions: [
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState.validate()) {
                  dispatcher(
                    CreateReviewAction(
                      restaurantId: widget.restaurantId,
                      comment: Optional(_commentController.text),
                      rating: _formRatingKey.currentState.currentRating,
                      visitDate: _formDateKey.currentState.visitDate,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RatingFormField(
                        key: _formRatingKey,
                        validator: (rating) => rating == null ? 'Please select rating' : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 5),
                        child: _DateFormField(
                          key: _formDateKey,
                          validator: (date) => date == null ? 'Please specify the date of visit' : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: TextFormField(
                          maxLines: null,
                          autocorrect: false,
                          controller: _commentController,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Comment',
                            hintText: 'Enter your comment here (optional)',
                            prefixIcon: Icon(Icons.create),
                          ),
                          validator: (value) => value.length > 200 ? 'Comment cannot exceed 200 characters' : null,
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

class _DateFormField extends FormField<DateTime> {
  _DateFormField({
    Key key,
    String Function(DateTime value) validator,
  }) : super(
          key: key,
          validator: validator,
          builder: (field) => Builder(
            builder: (context) {
              final state = field as _DateFormFieldState;

              return Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Date of visit: ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 30),
                          child: OutlinedButton(
                            onPressed: () => showDatePicker(
                              context: context,
                              initialDate: state.visitDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            ).then(state.didChange),
                            child: Text(
                              state.visitDate?.yearMonthDay ?? 'Select date',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (field.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        field.errorText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends FormFieldState<DateTime> {
  DateTime visitDate;

  @override
  void didChange(DateTime value) {
    super.didChange(value);

    visitDate = value;

    validate();
  }
}

class _RatingFormField extends FormField<int> {
  _RatingFormField({
    Key key,
    String Function(int rating) validator,
  }) : super(
          key: key,
          validator: validator,
          builder: (field) => Builder(
            builder: (context) {
              final state = field as _RatingFormFieldState;

              return Column(
                children: [
                  Row(
                    children: [
                      for (var i = 1; i <= 5; i++)
                        GestureDetector(
                          onTap: () => state.didChange(i),
                          child: Image.asset(
                            (state.currentRating ?? 0) >= i ? 'assets/star_filled.png' : 'assets/star_empty.png',
                            package: 'dashboard',
                            height: 45,
                          ),
                        ),
                    ],
                  ),
                  if (field.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        field.errorText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );

  @override
  _RatingFormFieldState createState() => _RatingFormFieldState();
}

class _RatingFormFieldState extends FormFieldState<int> {
  int currentRating;

  @override
  void didChange(int value) {
    super.didChange(value);

    currentRating = value;

    validate();
  }
}
