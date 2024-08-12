// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/account_profile.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/bank_details.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/business_details.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/calendar_profile.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/profile/setting.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Manage Profile",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            // Get.back();
          },
          child: Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
        actions: [
          Icon(
            Icons.support_agent,
            color: whiteColor,
          ),
          SizedBox(width: 5),
          PlainText(
            name: "Help",
            fontsize: 14,
            color: whiteColor,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildListTile(
                Icons.person,
                "Account",
                () {
                  Get.to(() => AccountProfile());
                },
              ),
              buildListTile(
                Icons.account_balance,
                "Bank Details",
                () {
                  Get.to(() => BankDetails());
                },
              ),
              buildListTile(
                Icons.settings,
                "Setting",
                () {
                  Get.to(() => SettingScreen());
                },
              ),
              buildListTile(
                Icons.business_center_outlined,
                "Business Details",
                () {
                  Get.to(() => BusinessDetails());
                },
              ),
              buildListTile(
                Icons.calendar_month,
                "Calendar",
                () {
                  Get.to(() => CalendarProfile());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildListTile(IconData iconData, String profileType, VoidCallback onTap) {
    return ListTile(
      tileColor: whiteColor,
      onTap: onTap,
      leading: Icon(
        iconData,
        color: blueColor,
      ),
      title: PlainText(
        name: profileType,
        fontsize: 17,
        color: blueColor,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: blueColor,
      ),
    );
  }
}
