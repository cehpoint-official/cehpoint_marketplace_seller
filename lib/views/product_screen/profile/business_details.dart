// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({super.key});

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Business Details",
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
                BoldText(name: "Business Details", fontsize: 20),
                hSpacer(h * 0.024),
                PlainText(name: "Business Details", fontsize: 16),
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
                PlainText(name: "TIN/ PROVISIONAL ID", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Business Address", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "Business Type", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.010),
                PlainText(name: "TIN Number", fontsize: 16),
                hSpacer(h * 0.010),
                buildTextFormField(
                  "will be already added",
                  TextEditingController(),
                ),
                hSpacer(h * 0.024),
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
