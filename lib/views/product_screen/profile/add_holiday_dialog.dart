// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class AddHolidayDialog extends StatefulWidget {
  const AddHolidayDialog({super.key});

  @override
  State<AddHolidayDialog> createState() => _AddHolidayDialogState();
}

class _AddHolidayDialogState extends State<AddHolidayDialog> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String selectedRadioButton = 'Regional Holiday';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: ContinuousRectangleBorder(),
      // contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      title: Text('Vacation Plan'),
      content: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: startDateController,
                  decoration: InputDecoration(
                    label: PlainText(
                      name: "DD/MM/YYYY",
                      fontsize: 14,
                      color: greyColor,
                    ),
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                    hintText: "Start Date",
                    hintStyle: TextStyle(color: greyColor),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              hSpacer(8),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: endDateController,
                  decoration: InputDecoration(
                    label: PlainText(
                      name: "DD/MM/YYYY",
                      fontsize: 14,
                      color: greyColor,
                    ),
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                    hintText: "End Date",
                    hintStyle: TextStyle(color: greyColor),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              PlainText(
                name: "Holiday Type",
                fontsize: 18,
                color: Colors.grey.shade600,
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0),
                title: Text('Regional Holiday'),
                leading: Radio(
                  value: 'Regional Holiday',
                  groupValue: selectedRadioButton,
                  onChanged: (value) {
                    setState(() {
                      selectedRadioButton = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0),
                title: Text('Festival'),
                leading: Radio(
                  value: 'Festival',
                  groupValue: selectedRadioButton,
                  onChanged: (value) {
                    setState(() {
                      selectedRadioButton = value.toString();
                    });
                  },
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0),
                title: Text('Personal Emergency'),
                leading: Radio(
                  value: 'Personal Emergency',
                  groupValue: selectedRadioButton,
                  onChanged: (value) {
                    setState(() {
                      selectedRadioButton = value.toString();
                    });
                  },
                ),
              ),
              hSpacer(8),
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10, left: 10),
                    hintText: "Comments *",
                    hintStyle: TextStyle(color: greyColor),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
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
              debugPrint('Holiday Type: $selectedRadioButton');
              debugPrint('Start Date: ${startDateController.text}');
              debugPrint('End Date: ${endDateController.text}');
              debugPrint('Comments: ${commentController.text}');
            },
          ),
        ),
      ],
    );
  }
}
