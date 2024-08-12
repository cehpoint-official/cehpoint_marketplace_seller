// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Account ",
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
                BoldText(name: "Display Information", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Store Name", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Business Description", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                BoldText(name: "Display Information", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Pick up Address", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Pick up pin code", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                BoldText(name: "Login Details", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Phone Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.024),
                PlainText(name: "Email ID", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Password", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                BoldText(name: "Contact Details", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Your Name", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.024),
                PlainText(name: "Your Mobile Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Your Email ID", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.024),
                RoundedButton(title: "Delete Account", onTap: () {})
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
