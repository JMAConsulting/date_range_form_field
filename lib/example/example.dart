import 'package:date_range_form_field/daterangeformfield.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyForm(),
    );
  }
}


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}
GlobalKey myFormKey = new GlobalKey();

class _MyFormState extends State<MyForm> {
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
            children: [SafeArea(
              child: DateRangeField(
                  context: context,
                  initialValue: DateTimeRange(start: DateTime.now(), end: DateTime.now()),
                  validator: (value) {
                    if (value.start.isBefore(DateTime.now())){
                      return 'Please enter a valid date';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    myDateRange = value;
                    print(myDateRange);
                  }
              ),
            ),
              FlatButton(
                child: Text(
                    'Submit'
                ),
                onPressed: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
  }
}