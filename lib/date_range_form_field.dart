import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DateRangeField extends FormField<DateTimeRange> {
  DateRangeField(
      {Key key,
      @required BuildContext context,

      /// This is the earliest date a user can select.
      ///
      /// If null, this will default to DateTime.now().
      DateTime firstDate,

      /// This is the latest date a user can select.
      ///
      /// If null, this will default to 5 years from now.
      DateTime lastDate,

      /// currentDate represents the the current day (today).
      ///
      /// If null, this default to DateTime.now().
      DateTime currentDate,

      /// This argument determines which mode the showDateRangePicker will initially display in.
      ///
      /// It defaults to a scrollable calendar month grid ([DatePickerEntryMode.calendar]).
      /// It can also be set to display two text input fields ([DatePickerEntryMode.input]).
      DatePickerEntryMode initialEntryMode,

      /// This is the label displayed at the top of the [showDateRangePicker] dialog.
      ///
      /// If null, this defaults to 'Select Date Range'.
      String helpText,

      /// This is the label on the cancel button for the text input mode.
      ///
      /// If null, this defaults to 'CANCEL'.
      String cancelText,

      /// This is the label on the ok button for the text input mode.
      ///
      /// If null, this defaults to 'OK'.
      String confirmText,

      /// This is the label on the save button for the calendar view.
      ///
      /// If null, this defaults to 'SAVE'.
      String saveText,

      /// This is the error message displayed when the input text is not a proper date format.
      ///
      /// For example, if the date format was 'MM-dd-yyyy', and the user enters 'Monday' this message will be displayed.
      /// If null, this defaults to 'Invalid format.'.
      String errorFormatText,

      /// This is the error message displayed when an input is not a selectable date.
      ///
      /// For example, if firstDate was set to 09-01-2020, and the user enters '09-01-2019' this message will be displayed.
      /// If null, this defaults to 'Out of range.'.
      String errorInvalidText,

      /// This is the error message displayed when an input is not a valid date range.
      ///
      /// For example, if the user selects a startDate after the endDate this message will be displayed.
      /// If null, this defaults to 'Invalid range.'.
      String errorInvalidRangeText,

      /// This is the label for the start date input text field.
      ///
      /// If null, this defaults to 'Start Date'.
      String fieldStartLabelText,

      /// This is the label for the end date input text field.
      ///
      /// If null, this default to 'End Date'.
      String fieldEndLabelText,

      /// This is the width of the widget.
      ///
      /// If null, this defaults to the width of the screen.
      double width,

      /// This is the margins of the widget.
      ///
      /// If null, this defaults to EdgeInsets.all(15.0).
      EdgeInsets margin,

      /// This is where you tell the widget what to do when the form is saved.
      ///
      /// For example:
      /// ```dart
      /// onSaved: (value) {
      ///   setState(() {
      ///     myDateRange = value;
      ///    });
      /// }
      /// ```
      FormFieldSetter<DateTimeRange> onSaved,

      /// This is where you can validate the user input.
      ///
      /// For example:
      /// ```dart
      /// validator: (value) {
      ///   if (value.start.isBefore(DateTime.now()) {
      ///     return 'Please enter a later start date.';
      ///   }
      ///   return null;
      /// }
      /// ```
      FormFieldValidator<DateTimeRange> validator,

      /// This required field is the initial DateTimeRange value of the widget.
      ///
      /// This value will be displayed upon first opening the dialog, and if the user does not choose another value it will be saved when the onSaved method is called.
      @required DateTimeRange initialValue,
      bool autoValidate = false,

      /// This is the format the widget will use for dates.
      ///
      /// Any valid format from the intl package is usable.
      /// If null, this will default to 'MM-dd-yyyy'.
      DateFormat dateFormat,

      /// This is how to decorate and customize the appearance of the widget.
      ///
      /// If null, this will use the defaults from the theme.
      InputDecoration decoration = const InputDecoration()})
      : assert(context != null),
        assert(autoValidate != null),
        super(
            validator: validator,
            onSaved: onSaved,
            initialValue: initialValue,
            builder: (FormFieldState<DateTimeRange> state) {
              final DateFormat format =
                  (dateFormat ?? DateFormat('MM-dd-yyyy'));
              final InputDecoration inputDecoration = (decoration ??
                      const InputDecoration())
                  .applyDefaults(Theme.of(state.context).inputDecorationTheme);

              /// This is the dialog to select the date range.
              Future<Null> selectDateRange(BuildContext context) async {
                DateTimeRange picked = await showDateRangePicker(
                    context: context,
                    initialDateRange: initialValue,
                    firstDate: firstDate ?? DateTime.now(),
                    lastDate: lastDate ?? DateTime(DateTime.now().year + 5),
                    helpText: helpText ?? 'Select Date Range',
                    cancelText: cancelText ?? 'CANCEL',
                    confirmText: confirmText ?? 'OK',
                    saveText: saveText ?? 'SAVE',
                    errorFormatText: errorFormatText ?? 'Invalid format.',
                    errorInvalidText: errorInvalidText ?? 'Out of range.',
                    errorInvalidRangeText:
                        errorInvalidRangeText ?? 'Invalid range.',
                    fieldStartHintText: fieldStartLabelText ?? 'Start Date',
                    fieldEndLabelText: fieldEndLabelText ?? 'End Date');
                if (picked != null) {
                  state.didChange(picked);
                }
              }

              return InkWell(
                /// This calls the dialog to select the date range.
                onTap: () {
                  selectDateRange(context);
                },
                child: Container(
                    margin: margin ?? EdgeInsets.all(15.0),
                    width: width ?? MediaQuery.of(context).size.width,
                    child: InputDecorator(
                      decoration:
                          inputDecoration.copyWith(errorText: state.errorText),
                      child: Text(

                          /// This displays the selected date range when the dialog is closed.
                          '${format.format(state.value.start)} - ${format.format(state.value.end)}'),
                    )),
              );
            });
}
