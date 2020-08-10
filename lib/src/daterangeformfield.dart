import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DateRangeField extends FormField<DateTimeRange> {


  DateRangeField({
    @required BuildContext context,
    FormFieldSetter<DateTimeRange> onSaved,
    FormFieldValidator<DateTimeRange> validator,
    @required DateTimeRange initialValue,
  }) : super(
      validator: validator,
      onSaved: onSaved,
      initialValue: initialValue,
      builder: (FormFieldState<DateTimeRange> state) {
        Future<Null> selectDateRange(BuildContext context) async {
          DateTimeRange picked = await showDateRangePicker(
            context: context,
            initialDateRange: initialValue,
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 5),
            helpText: 'Select Date Range',
          );
          state.didChange(picked);
        }
        return Container(
          child: ListTile(
              leading: Icon(Icons.date_range),
              title: Text(
                  'From ${DateFormat('yyyy-MM-dd').format(state.value.start)} to ${DateFormat('yyyy-MM-dd').format(state.value.end)}'
              ),
              onTap: () {
                selectDateRange(context);
              }),
        );
      }
  );
}

