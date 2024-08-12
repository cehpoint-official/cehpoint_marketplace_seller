// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Listing_Page/Listing_page.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Sell_More.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Service_feedback.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Ticket_page.dart';
import 'package:cehpoint_marketplace_seller/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/payments/payments.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future logOut() async {
    try {
      await auth.signOut();
      Get.to(() => const LoginPage());
      Utils().toastMessage("Successfully Logged Out!");
    } catch (e) {
      Utils().toastMessage(e.toString());

      debugPrint('Failed to sign in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildHeader(context),
        buildMenuItems(context),
      ],
    ));
  }

  Widget buildHeader(BuildContext context) => Container(
        color: appColor,

        padding: const EdgeInsets.only(top: 40, left: 30),
        // decoration: BoxDecoration(),
        child: Row(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              height: 85,
              width: 85,
              child: Image.asset(
                "assets/images/shop.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlainText(
                  name: "XyZ Store",
                  fontsize: 18,
                  color: whiteColor,
                ),
                PlainText(
                  name: "xyz@gmail.com",
                  fontsize: 14,
                  color: whiteColor,
                )
              ],
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        color: whiteColor,
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const BoldText(
                name: "Home",
                fontsize: 13,
              ),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
              ),
              title: const BoldText(
                name: "Listing",
                fontsize: 13,
              ),
              onTap: () {
                Get.to(() => const Listing());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
              ),
              title: const BoldText(
                name: "Customer Questions",
                fontsize: 13,
              ),
              onTap: () {
                // debugPrint(userName);

                Get.to(());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_cart_outlined,
              ),
              title: const BoldText(
                name: "Orders",
                fontsize: 13,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.keyboard_return,
              ),
              title: const BoldText(
                name: "Returns",
                fontsize: 13,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.payments,
              ),
              title: const BoldText(
                name: "Payments",
                fontsize: 13,
              ),
              onTap: () {
                Get.to(() => const PaymentsScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_bag,
              ),
              title: const BoldText(
                name: "Sell More",
                fontsize: 13,
              ),
              onTap: () {
                Get.to(() => const Sell_More());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.tv,
              ),
              title: const BoldText(
                name: "Advertising",
                fontsize: 13,
              ),
              onTap: () {
                Get.to(());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.mail_outline_outlined,
              ),
              title: const BoldText(
                name: "My Tickets",
                fontsize: 13,
              ),
              onTap: () {
                Get.to(() => const Ticket());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_outlined,
              ),
              title: const BoldText(
                name: "Send FeedBack",
                fontsize: 13,
              ),
              onTap: () {
                Get.to(() => const FeedBack());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const BoldText(
                name: "Log Out",
                fontsize: 13,
              ),
              onTap: () {
                logOut();
                debugPrint('$auth.currentUser');
              },
            ),
          ],
        ),
      );
}
