import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DateRangeField extends FormField<DateTimeRange> {
  DateRangeField(
      {Key key,
      @required BuildContext context,
      double width,
      EdgeInsets margin,
      FocusNode focusNode,
      FormFieldSetter<DateTimeRange> onSaved,
      FormFieldValidator<DateTimeRange> validator,
      @required DateTimeRange initialValue,
      bool autoValidate = false,
      DateFormat dateFormat,
      InputDecoration decoration = const InputDecoration()})
      : assert(initialValue != null),
        assert(context != null),
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
              Future<Null> selectDateRange(BuildContext context) async {
                DateTimeRange picked = await showDateRangePicker(
                  context: context,
                  initialDateRange: initialValue,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 5),
                  helpText: 'Select Date Range',
                );
                if (picked != null) {
                  state.didChange(picked);
                }
              }

              return InkWell(
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
                          '${format.format(state.value.start)} - ${format.format(state.value.end)}'),
                    )),
              );
            });
}
