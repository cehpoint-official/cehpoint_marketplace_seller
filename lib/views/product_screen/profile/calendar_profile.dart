// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/add_holiday_dialog.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/set_day_dialog.dart';

class CalendarProfile extends StatefulWidget {
  const CalendarProfile({super.key});

  @override
  State<CalendarProfile> createState() => _CalendarProfileState();
}

class _CalendarProfileState extends State<CalendarProfile> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Calendar",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
        actions: [
          Icon(
            Icons.notifications_outlined,
            color: whiteColor,
          ),
          SizedBox(width: w * 0.05),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PlainText(name: "Vocation Plan", fontsize: 18),
                  SizedBox(width: w * 0.21),
                  SizedBox(
                    height: 40,
                    width: 138,
                    child: RoundedButton(
                      title: "Add Holiday",
                      textColor: blueColor,
                      borderColor: blueColor,
                      radius: 5,
                      buttonColor: Colors.lightBlue.withOpacity(0.2),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddHolidayDialog();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              hSpacer(h * 0.025),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF10BC55).withOpacity(.25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: PlainText(
                        name: "08/08/2023 to 10/08/2023 (Personal Emergency)",
                        color: greenColor,
                        fontsize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: PlainText(
                        name: "CANCEL",
                        color: greyColor,
                        fontsize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              hSpacer(h * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PlainText(name: "Working Hours", fontsize: 18),
                      SizedBox(width: w * 0.25),
                      SizedBox(
                        height: 40,
                        width: 115,
                        child: RoundedButton(
                          title: "Set Time",
                          textColor: blueColor,
                          borderColor: blueColor,
                          radius: 5,
                          buttonColor: Colors.lightBlue.withOpacity(0.2),
                          onTap: () async {
                            DateTime firstDateTime =
                                await selectDateTime(context);
                            DateTime secondDateTime =
                                await selectDateTime(context);

                            if (firstDateTime != null &&
                                secondDateTime != null) {
                              debugPrint('First Date and Time: $firstDateTime');
                              debugPrint(
                                  'Second Date and Time: $secondDateTime');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  PlainText(name: "11:00 AM to 07:00 PM", fontsize: 16),
                ],
              ),
              hSpacer(h * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PlainText(name: "Weekly off", fontsize: 18),
                      SizedBox(width: w * 0.35),
                      SizedBox(
                        height: 40,
                        width: 115,
                        child: RoundedButton(
                          title: "Set Day",
                          textColor: blueColor,
                          borderColor: blueColor,
                          radius: 5,
                          buttonColor: Colors.lightBlue.withOpacity(0.2),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SetDayDialog();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  PlainText(name: "Sunday", fontsize: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> selectDateTime(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }

    return selectedDate;
  }
}
