// Copyright 2020 JMA Consulting. All rights reserved.
// Use of this source code is governed by a BSD-style license which can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

/// A [DateRangeField] which extends a [FormField].
///
/// The use of a [Form] ancestor is not required, however it makes it easier to
/// save, reset, and validate multiple fields at the same time. In order to use
/// this without a [Form] ancestor, pass a [GlobalKey] to the constructor and use
/// [GlobalKey.currentState] the same way as you would for a form.
///
/// To style this widget, pass an [InputDecoration] to the constructor. If not,
/// the [DateRangeField] will use the default from the [Theme].
///
/// This widget must have a [Material] ancestor, such as a [MaterialApp] or [Form].
class DateRangeField extends FormField<DateTimeRange> {
  /// Creates a [DateRangeField] which extends a [FormField].
  ///
  /// When using without a [Form] ancestor a [GlobalKey] is required.
  DateRangeField(
      {Key key,
      @required BuildContext context,
      this.firstDate,
      this.lastDate,
      this.currentDate,
      this.initialEntryMode,
      this.helpText,
      this.cancelText,
      this.confirmText,
      this.saveText,
      this.errorFormatText,
      this.errorInvalidText,
      this.errorInvalidRangeText,
      this.fieldStartLabelText,
      this.fieldEndLabelText,
      this.width,
      this.margin,
      FormFieldSetter<DateTimeRange> onSaved,
      FormFieldValidator<DateTimeRange> validator,
      @required this.initialValue,
      bool autoValidate = false,
      this.dateFormat,
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
                  state.save();
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

  /// This is the earliest date a user can select.
  ///
  /// If null, this will default to DateTime.now().
  final DateTime firstDate;

  /// This is the latest date a user can select.
  ///
  /// If null, this will default to 5 years from now.
  final DateTime lastDate;

  /// currentDate represents the the current day (today).
  ///
  /// If null, this default to DateTime.now().
  final DateTime currentDate;

  /// This argument determines which mode the showDateRangePicker will initially display in.
  ///
  /// It defaults to a scrollable calendar month grid ([DatePickerEntryMode.calendar]).
  /// It can also be set to display two text input fields ([DatePickerEntryMode.input]).
  final DatePickerEntryMode initialEntryMode;

  /// This is the label displayed at the top of the [showDateRangePicker] dialog.
  ///
  /// If null, this defaults to 'Select Date Range'.
  final String helpText;

  /// This is the label on the cancel button for the text input mode.
  ///
  /// If null, this defaults to 'CANCEL'.
  final String cancelText;

  /// This is the label on the ok button for the text input mode.
  ///
  /// If null, this defaults to 'OK'.
  final String confirmText;

  /// This is the label on the save button for the calendar view.
  ///
  /// If null, this defaults to 'SAVE'.
  final String saveText;

  /// This is the error message displayed when the input text is not a proper date format.
  ///
  /// For example, if the date format was 'MM-dd-yyyy', and the user enters 'Monday' this message will be displayed.
  /// If null, this defaults to 'Invalid format.'.
  final String errorFormatText;

  /// This is the error message displayed when an input is not a selectable date.
  ///
  /// For example, if firstDate was set to 09-01-2020, and the user enters '09-01-2019' this message will be displayed.
  /// If null, this defaults to 'Out of range.'.
  final String errorInvalidText;

  /// This is the error message displayed when an input is not a valid date range.
  ///
  /// For example, if the user selects a startDate after the endDate this message will be displayed.
  /// If null, this defaults to 'Invalid range.'.
  final String errorInvalidRangeText;

  /// This is the label for the start date input text field.
  ///
  /// If null, this defaults to 'Start Date'.
  final String fieldStartLabelText;

  /// This is the label for the end date input text field.
  ///
  /// If null, this default to 'End Date'.
  final String fieldEndLabelText;

  /// This is the width of the widget.
  ///
  /// If null, this defaults to the width of the screen.
  final double width;

  /// This is the margins of the widget.
  ///
  /// If null, this defaults to EdgeInsets.all(15.0).
  final EdgeInsets margin;

  /// This required field is the initial DateTimeRange value of the widget.
  ///
  /// This value will be displayed upon first opening the dialog, and if the user does not choose another value it will be saved when the onSaved method is called.
  final DateTimeRange initialValue;

  /// This is the format the widget will use for dates.
  ///
  /// Any valid format from the intl package is usable.
  /// If null, this will default to 'MM-dd-yyyy'.
  final DateFormat dateFormat;
}
