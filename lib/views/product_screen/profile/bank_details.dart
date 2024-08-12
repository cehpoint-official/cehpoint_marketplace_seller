// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Bank Details",
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
                BoldText(name: "Bank Information", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "TIN Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "VRN (Optional)", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.01),
                PlainText(name: "Name of holder", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Account Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "LDC Details", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                BoldText(name: "Provide LDC Details", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Certificate Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Lower Tax Rate", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Phone Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "14/08/2023",
                  ),
                ),
                hSpacer(h * 0.010),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "14/08/2024",
                  ),
                ),
                hSpacer(h * 0.024),
                RoundedButton(title: "Upload Documents", onTap: () {})
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
