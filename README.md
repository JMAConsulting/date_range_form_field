# date_range_form_field

A Flutter package for adding a DateRange widget into a form. 
The widget will accept InputDecoration or use the default from the app's theme.
Additionally, the widget will accept a date format, defaulting to MM-dd-yyyy.

# Example
``` dart
// Import package
import 'package:flutter/material.dart';
import 'package:date_range_form_field/date_range_form_field.dart';

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

// Make a form
class MyFormField extends StatefulWidget {
  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

GlobalKey myFormKey = new GlobalKey();

class _MyFormFieldState extends State<MyFormField> {
  DateTimeRange myDateRange;

  void _submitForm() {
    final FormState form = myFormKey.currentState;
    form.save();
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
                    context: context,
                    decoration: InputDecoration(
                      labelText: 'Date Range',
                      prefixIcon: Icon(Icons.date_range),
                      hintText: 'Please select a start and end date',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: DateTimeRange(
                        start: DateTime.now(), end: DateTime.now()),
                    validator: (value) {
                      if (value.start.isBefore(DateTime.now())) {
                        return 'Please enter a valid date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        myDateRange = value;
                      });
                    }),
              ),
              FlatButton(
                child: Text('Submit'),
                onPressed: _submitForm,
              ),
              if(myDateRange != null) Text("Saved value is: ${myDateRange.toString()}")
            ],
          ),
        ),
      ),
    );
  }
}
```

![example_video](https://user-images.githubusercontent.com/65566908/91237186-f0440b80-e707-11ea-919f-846d0c6504c4.gif)
