# date_range_form_field

A Flutter package for adding a DateRange widget into a form.
A date picker UX is provided by showDateRangePicker. 
The widget will accept InputDecoration or use the default from the app's theme.
Additionally, the widget will accept a date format, defaulting to MM-dd-yyyy.

# Usage

This widget should be used like any other FormField within a form.
It is important to note that the firstDate and lastDate properties correspond to the first and last valid dates.
This widget must have a MaterialWidget ancestor, such as a MaterialApp

# Example

<img src="https://user-images.githubusercontent.com/65566908/91237186-f0440b80-e707-11ea-919f-846d0c6504c4.gif" height="500"/>

``` dart
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyFormField(),
    );
  }
}

class MyFormField extends StatefulWidget {
  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

GlobalKey<FormState> myFormKey = new GlobalKey();

class _MyFormFieldState extends State<MyFormField> {
  DateTimeRange? myDateRange;

  void _submitForm() {
    final FormState? form = myFormKey.currentState;
    form!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Range Form Example"),
      ),
      body: SafeArea(
        child: Form(
          key: myFormKey,
          child: Column(
            children: [
              SafeArea(
                child: DateRangeField(
                    enabled: true,
                    initialValue: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(Duration(days: 5))),
                    decoration: InputDecoration(
                      labelText: 'Date Range',
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Please select a start and end date',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.start.isBefore(DateTime.now())) {
                        return 'Please enter a later start date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        myDateRange = value!;
                      });
                    }),
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: _submitForm,
              ),
              if (myDateRange != null)
                Text("Saved value is: ${myDateRange.toString()}")
            ],
          ),
        ),
      ),
    );
  }
}

```

# Contributing

Contributions are welcome as pull requests to the github repo.
Please open issues on the repo for feature requests or bug reports.
