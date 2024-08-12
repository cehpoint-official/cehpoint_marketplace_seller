// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Settings",
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(name: "Printer Settings", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Enable Thermal Printing", fontsize: 16),
                hSpacer(h * 0.024),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: RoundedButton(
                    title: isTapped ? "Enabled" : "Disabled",
                    buttonColor: isTapped ? greenColor : greyColor,
                    radius: 0,
                    onTap: () {
                      setState(() {
                        isTapped = !isTapped;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTextFormField(String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
