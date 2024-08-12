// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/auth/login_page.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/advertisement/advertisement_screen.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/listing_screen/listing_home_screen.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/order/customer_order.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/order/return_order.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/payments/payments.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/sell_more.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/feedback_QA/send_feedback.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/ticket_screen.dart';

class NavDrawer extends StatefulWidget {
  final String email;
  const NavDrawer({super.key, required this.email});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final TextEditingController editUsername = TextEditingController();
  String user = "";
  String usernamee = "";
  String avatarurl = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future logOut() async {
    try {
      await auth.signOut();
      Get.to(() => LoginPage());
      Utils().toastMessage("Successfully Logged Out!");
    } catch (e) {
      Utils().toastMessage(e.toString());

      debugPrint('Failed to sign in: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSellerDetails();
  }

  @override
  Widget build(BuildContext context) {
    // var h = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Drawer(
          child: SizedBox(
            height: 650,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildHeader(context),
                  buildMenuItems(context),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.sizeOf(context).height * 0.4,
            child: Container(
                height: 40,
                width: 304,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(199, 0, 0, 0),
                ),
                child: const Center(
                    child: Text(
                  "This Drawer is under Development",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )))),
      ],
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        color: appColor,
        padding: const EdgeInsets.only(top: 40, left: 10, bottom: 10),
        child: Row(
          children: [
            Stack(children: [
              Container(
                width: 85,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1)),
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(avatarurl),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      // viewImage();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(Icons.camera_alt),
                    ),
                  )),
            ]),
            const SizedBox(width: 15),
            SizedBox(
              width: 304 - 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 304 - 160,
                        child: PlainText(
                          name: usernamee,
                          fontsize: 22,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: editUsername,
                                              decoration: const InputDecoration(
                                                labelText: 'Edit Username',
                                              ),
                                            ),
                                            const SizedBox(height: 35.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: appColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (editUsername.text !=
                                                        "") {
                                                      updateDisplayName();
                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    } else {
                                                      Utils().toastMessage(
                                                          "Username Cannot be empty");
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: appColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: const Text('  Save  '),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  PlainText(
                    name: widget.email,
                    fontsize: 14,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.84,
        color: whiteColor,
        padding: EdgeInsets.only(left: 30),
        child: Column(
          children: [
            buildMenuItem(Icons.home, "Home", () => Get.back()),
            buildMenuItem(
                Icons.list, "Listing", () => Get.to(() => ListingHomeScreen())),
            buildMenuItem(Icons.chat, "Customer Questions", () {
              // Get.to(() => CustomerQuestions());
            }),
            buildMenuItem(Icons.shopping_cart_outlined, "Orders",
                () => Get.to(() => CustomerOrder())),
            buildMenuItem(Icons.keyboard_return, "Returns",
                () => Get.to(() => ReturnOrder())),
            buildMenuItem(Icons.payments, "Payments",
                () => Get.to(() => PaymentsScreen())),
            buildMenuItem(Icons.shopping_bag, "Sell More",
                () => Get.to(() => SellMoreScreen())),
            buildMenuItem(Icons.tv, "Advertising",
                () => Get.to(() => AdvertisementScreen())),
            buildMenuItem(Icons.mail_outline_outlined, "My Tickets",
                () => Get.to(() => TicketScreen())),
            buildMenuItem(Icons.chat_outlined, "Send Feedback",
                () => Get.to(() => SendFeedBack())),
            buildMenuItem(
                Icons.logout, "Log Out", () => showLogoutDialog(context)),
          ],
        ),
      );

  Widget buildMenuItem(IconData icon, String title, Function() onTap) =>
      ListTile(
        contentPadding: EdgeInsets.all(-16),
        leading: Icon(icon),
        title: BoldText(
          name: title,
          fontsize: 13,
        ),
        onTap: onTap,
      );

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => showAlertDialog("logout"),
    );
  }

  Widget showAlertDialog(String ans) {
    return AlertDialog(
      title: BoldText(
        name: "Are you sure to $ans your invitation",
        fontsize: 17,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              title: "Cancel",
              buttonColor: blueColor,
              onTap: () {
                Get.back();
              },
            ),
            RoundedButton(
              title: "Logout",
              onTap: () {
                logOut();
                debugPrint('$auth.currentUser');
              },
              buttonColor: redColor,
            ),
          ],
        ),
      ),
    );
  }

  void fetchSellerDetails() async {
    try {
      DocumentSnapshot sellerDoc =
          await firestore.collection('users').doc(widget.email).get();
      //  firestore.collection(widget.email).doc('Seller').get();

      if (sellerDoc.exists) {
        var displayName = sellerDoc.get('Name');
        var url = sellerDoc.get('Avatar');
        setState(() {
          editUsername.text = displayName;
          usernamee = displayName;
          avatarurl = url;
        });
      } else {
        debugPrint('Seller document not found!');
      }
    } catch (error) {
      debugPrint('Error fetching seller details: $error');
    }
  }

  void updateDisplayName() async {
    try {
      firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(widget.email).update({
        'Display Name': editUsername.text,
      });
      fetchSellerDetails();
      Utils().toastMessage("Username Updated Successfully!");
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }
}
