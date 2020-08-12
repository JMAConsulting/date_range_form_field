import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DateRangeField extends FormField<DateTimeRange> {


  DateRangeField({
    Key key,
    @required BuildContext context,
    FormFieldSetter<DateTimeRange> onSaved,
    FormFieldValidator<DateTimeRange> validator,
    @required DateTimeRange initialValue,
    bool autoValidate = false,
    InputDecoration decoration = const InputDecoration()
  }) :  assert (initialValue != null),
        assert (context != null),
        assert (autoValidate != null),
        super(
      validator: validator,
      onSaved: onSaved,
      initialValue: initialValue,
      builder: (FormFieldState<DateTimeRange> state) {
        final InputDecoration inputDecoration = (decoration ?? const InputDecoration())
        .applyDefaults(Theme.of(state.context).inputDecorationTheme);
        Future<Null> selectDateRange(BuildContext context) async {
          DateTimeRange picked = await showDateRangePicker(
            context: context,
            initialDateRange: initialValue,
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 5),
            helpText: 'Select Date Range',
          );
          if (picked != null){
            state.didChange(picked);
          }
        }
        return InputDecorator(
          decoration: inputDecoration.copyWith(errorText: state.errorText),
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

