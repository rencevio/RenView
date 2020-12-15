import 'package:communicator/communicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plain_optional/plain_optional.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

Future<void> showReviewCreationDialog(
  BuildContext context, {
  @required Dispatcher dispatcher,
  @required String restaurantId,
}) =>
    showDialog(
      context: context,
      child: CreateEditReviewDialog(
        headerTitle: 'Create a review',
        actionTitle: 'Create',
        onConfirm: ({comment, rating, visitDate}) => dispatcher(
          CreateReviewAction(
            restaurantId: restaurantId,
            comment: Optional(comment),
            rating: rating,
            visitDate: visitDate,
          ),
        ),
      ),
    );

Future<void> showReviewEditDialog(
  BuildContext context, {
  @required Dispatcher dispatcher,
  @required String reviewId,
  @required int rating,
  @required DateTime visitDate,
  String comment,
}) =>
    showDialog(
      context: context,
      child: CreateEditReviewDialog(
        comment: comment,
        rating: rating,
        visitDate: visitDate,
        headerTitle: 'Edit your review',
        actionTitle: 'Edit',
        onConfirm: ({comment, rating, visitDate}) => dispatcher(
          EditReviewAction(
            reviewId: reviewId,
            comment: Optional(comment),
            rating: rating,
            visitDate: visitDate,
          ),
        ),
      ),
    );

class CreateEditReviewDialog extends StatefulWidget {
  const CreateEditReviewDialog({
    @required this.onConfirm,
    @required this.headerTitle,
    @required this.actionTitle,
    this.comment,
    this.rating,
    this.visitDate,
    Key key,
  }) : super(key: key);

  @override
  _CreateEditReviewDialogState createState() => _CreateEditReviewDialogState();

  final String comment;
  final int rating;
  final DateTime visitDate;
  final String headerTitle;
  final String actionTitle;
  final void Function({@required String comment, @required int rating, @required DateTime visitDate}) onConfirm;
}

class _CreateEditReviewDialogState extends State<CreateEditReviewDialog> {
  final _commentController = TextEditingController();
  DateTime visitDate;

  final _formKey = GlobalKey<FormState>();
  final _formDateKey = GlobalKey<_DateFormFieldState>();
  final _formRatingKey = GlobalKey<_RatingFormFieldState>();

  @override
  void initState() {
    super.initState();

    _commentController.text = widget.comment;
  }

  @override
  Widget build(BuildContext context) => Consumer<Dispatcher>(
        builder: (context, dispatcher, _) => AlertDialog(
          contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          title: Text(widget.headerTitle),
          actions: [
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();

                if (_formKey.currentState.validate()) {
                  widget.onConfirm(
                    comment: _commentController.text,
                    rating: _formRatingKey.currentState.currentRating,
                    visitDate: _formDateKey.currentState.visitDate,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text(widget.actionTitle),
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
                        _RatingFormField(
                          key: _formRatingKey,
                          initialValue: widget.rating,
                          validator: (rating) => rating == null ? 'Please select rating' : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 5),
                          child: _DateFormField(
                            key: _formDateKey,
                            initialValue: widget.visitDate,
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
                ),
              );
            },
          ),
        ),
      );
}

class _DateFormField extends FormField<DateTime> {
  _DateFormField({
    @required DateTime initialValue,
    Key key,
    String Function(DateTime value) validator,
  }) : super(
          key: key,
          validator: validator,
          initialValue: initialValue,
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
  void initState() {
    super.initState();
    visitDate = widget.initialValue;
  }

  @override
  void didChange(DateTime value) {
    super.didChange(value);

    visitDate = value;

    validate();
  }
}

class _RatingFormField extends FormField<int> {
  _RatingFormField({
    @required int initialValue,
    Key key,
    String Function(int rating) validator,
  }) : super(
          key: key,
          initialValue: initialValue,
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
  void initState() {
    super.initState();
    currentRating = widget.initialValue;
  }

  @override
  void didChange(int value) {
    super.didChange(value);

    currentRating = value;

    validate();
  }
}
