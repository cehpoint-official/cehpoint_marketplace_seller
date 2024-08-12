// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class SetDayDialog extends StatefulWidget {
  const SetDayDialog({super.key});

  @override
  State<SetDayDialog> createState() => _SetDayDialogState();
}

class _SetDayDialogState extends State<SetDayDialog> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String selectedDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: ContinuousRectangleBorder(),
      // contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      title: Text('Select Day'),
      content: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDayListTile('Monday'),
              buildDayListTile('Tuesday'),
              buildDayListTile('Wednesday'),
              buildDayListTile('Thursday'),
              buildDayListTile('Friday'),
              buildDayListTile('Saturday'),
              buildDayListTile('Sunday'),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          height: 50,
          width: 150,
          child: RoundedButton(
            title: "Save",
            radius: 30,
            onTap: () {
              Navigator.of(context).pop();
              debugPrint('Selected Day: $selectedDay');
            },
          ),
        ),
      ],
    );
  }

  Widget buildDayListTile(String day) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      title: Text(day),
      leading: Radio(
        value: day,
        groupValue: selectedDay,
        onChanged: (value) {
          setState(() {
            selectedDay = value.toString();
          });
        },
      ),
    );
  }
}
