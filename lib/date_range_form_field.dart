// Copyright 2020, 2021 JMA Consulting. All rights reserved.
// Use of this source code is governed by a BSD-style license which can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
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
      {Key? key,
      this.firstDate,
      this.lastDate,
      this.currentDate,
      this.initialEntryMode,
      this.helpText,
      this.cancelText,
      this.enabled = true,
      this.confirmText,
      this.saveText,
      this.errorFormatText,
      this.errorInvalidText,
      this.errorInvalidRangeText,
      this.fieldStartHintText,
      this.fieldEndHintText,
      this.fieldStartLabelText,
      this.fieldEndLabelText,
      this.width,
      this.margin,
      ValueChanged<DateTimeRange?>? onChanged,
      FormFieldSetter<DateTimeRange>? onSaved,
      FormFieldValidator<DateTimeRange>? validator,
      this.initialValue,
      bool autoValidate = false,
      this.dateFormat,
      this.textStyle,
      InputDecoration decoration = const InputDecoration()})
      : super(
            key: key,
            validator: validator,
            onSaved: onSaved,
            enabled: enabled,
            initialValue: initialValue,
            builder: (FormFieldState<DateTimeRange> state) {
              final DateFormat format =
                  (dateFormat ?? DateFormat('MM/dd/yyyy'));
              final InputDecoration inputDecoration = decoration
                  .copyWith(enabled: enabled)
                  .applyDefaults(Theme.of(state.context).inputDecorationTheme);
              if (state.value == null && initialValue != null) {
                state.setValue(DateTimeRange(
                    start: initialValue.start,
                    end: initialValue.end));
              }

              /// This is the dialog to select the date range.
              Future<Null> selectDateRange() async {
                DateTimeRange? picked = await showDateRangePicker(
                        context: state.context,
                        initialDateRange: initialValue,
                        firstDate: firstDate ?? DateTime.now(),
                        lastDate: lastDate ?? DateTime.now().add(Duration(days: 5)),
                        helpText: helpText ?? 'Select Date Range',
                        cancelText: cancelText ?? 'CANCEL',
                        confirmText: confirmText ?? 'OK',
                        saveText: saveText ?? 'SAVE',
                        errorFormatText: errorFormatText ?? 'Invalid format.',
                        errorInvalidText: errorInvalidText ?? 'Out of range.',
                        errorInvalidRangeText:
                            errorInvalidRangeText ?? 'Invalid range.',
                        fieldStartHintText: fieldStartHintText ?? 'Start Date',
                        fieldEndHintText: fieldEndHintText ?? 'End Date',
                        fieldStartLabelText: fieldStartLabelText ?? 'Start Date',
                        fieldEndLabelText: fieldEndLabelText ?? 'End Date') ??
                    state.value;
                if (picked != state.value) {
                  state.didChange(picked);
                  onChanged?.call(picked);
                }
              }

              String hintText = decoration.hintText ?? '';
              return InkWell(
                /// This calls the dialog to select the date range.
                onTap: enabled ? selectDateRange : null,
                child: Container(
                  margin: margin ?? EdgeInsets.all(15.0),
                  width: width ?? MediaQuery.of(state.context).size.width,
                  child: InputDecorator(
                    decoration:
                        inputDecoration.copyWith(errorText: state.errorText),
                    child: Text(
                        // This will display hintText if provided and if state.value is null
                        state.value == null
                            ? hintText
                            :

                            /// This displays the selected date range when the dialog is closed.
                            '${format.format(state.value!.start)} - ${format.format(state.value!.end)}',
                        style: (state.value == null &&
                                hintText != '' &&
                                decoration.hintStyle != null)
                            ? decoration.hintStyle
                            : textStyle),
                  ),
                ),
              );
            });

  /// This is the earliest date a user can select.
  ///
  /// If null, this will default to DateTime.now().
  final DateTime? firstDate;

  /// This is the latest date a user can select.
  ///
  /// If null, this will default to 5 years from now.
  final DateTime? lastDate;

  /// currentDate represents the the current day (today).
  ///
  /// If null, this default to DateTime.now().
  final DateTime? currentDate;

  /// This argument determines which mode the showDateRangePicker will initially display in.
  ///
  /// It defaults to a scrollable calendar month grid ([DatePickerEntryMode.calendar]).
  /// It can also be set to display two text input fields ([DatePickerEntryMode.input]).
  final DatePickerEntryMode? initialEntryMode;

  /// This is the label displayed at the top of the [showDateRangePicker] dialog.
  ///
  /// If null, this defaults to 'Select Date Range'.
  final String? helpText;

  /// This is the label on the cancel button for the text input mode.
  ///
  /// If null, this defaults to 'CANCEL'.
  final String? cancelText;

  /// Whether input should be enabled.
  ///
  /// If null, this defaults to true.
  final bool enabled;

  /// This is the label on the ok button for the text input mode.
  ///
  /// If null, this defaults to 'OK'.
  final String? confirmText;

  /// This is the label on the save button for the calendar view.
  ///
  /// If null, this defaults to 'SAVE'.
  final String? saveText;

  /// This is the error message displayed when the input text is not a proper date format.
  ///
  /// For example, if the date format was 'MM-dd-yyyy', and the user enters 'Monday' this message will be displayed.
  /// If null, this defaults to 'Invalid format.'.
  final String? errorFormatText;

  /// This is the error message displayed when an input is not a selectable date.
  ///
  /// For example, if firstDate was set to 09-01-2020, and the user enters '09-01-2019' this message will be displayed.
  /// If null, this defaults to 'Out of range.'.
  final String? errorInvalidText;

  /// This is the error message displayed when an input is not a valid date range.
  ///
  /// For example, if the user selects a startDate after the endDate this message will be displayed.
  /// If null, this defaults to 'Invalid range.'.
  final String? errorInvalidRangeText;

  /// This is the text used to prompt the user when no text has been entered in the start field.
  ///
  /// If null, this defaults to 'Start Date'.
  final String? fieldStartHintText;

  /// This is the text used to prompt the user when no text has been entered in the end field.
  ///
  /// If null, this defaults to 'End Date'.
  final String? fieldEndHintText;

  /// This is the label for the start date input text field.
  ///
  /// If null, this defaults to 'Start Date'.
  final String? fieldStartLabelText;

  /// This is the label for the end date input text field.
  ///
  /// If null, this default to 'End Date'.
  final String? fieldEndLabelText;

  /// This is the width of the widget.
  ///
  /// If null, this defaults to the width of the screen.
  final double? width;

  /// This is the margins of the widget.
  ///
  /// If null, this defaults to EdgeInsets.all(15.0).
  final EdgeInsets? margin;

  /// This required field is the initial DateTimeRange value of the widget.
  ///
  /// This value will be displayed upon first opening the dialog, and if the user does not choose another value it will be saved when the onSaved method is called.
  final DateTimeRange? initialValue;

  /// This is the format the widget will use for dates.
  ///
  /// Any valid format from the intl package is usable.
  /// If null, this will default to 'MM/dd/yyyy'.
  final DateFormat? dateFormat;

  /// This is the default [TextStyle] of the field.
  ///
  /// If a hintStyle is provided in the decoration, then the hintStyle will be applied when the hintText is displayed.
  /// If null, this will default to ([DefaultTextStyle])
  final TextStyle? textStyle;
}
