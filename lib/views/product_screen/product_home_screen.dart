// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/nav_drawer.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/notifications/notification_page.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/listing_screen/new_listing.dart';

class ProductHomeScreen extends StatefulWidget {
  final String email;
  const ProductHomeScreen({super.key, required this.email});

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: NavDrawer(email: widget.email),
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: Row(
          children: [
            SizedBox(
              height: 35,
              width: 36,
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(width: 10),
            PlainText(
              name: "Cehpoint Marketplace",
              fontsize: 20,
              color: whiteColor,
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Icon(
              Icons.notifications,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: w,
                  child: Image.asset(
                    "assets/images/shop.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45,
                        child: RoundedButton(
                          title: "Start Listing",
                          onTap: () {
                            Get.to(() => ListingScreen());
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 254,
                        width: w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/chart.png")),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: greyColor),
                          // color: appColor,
                        ),
                        // child: Center(
                        //     child: BoldText(name: "Chart Loading!!", fontsize: 16)),
                      ),
                      SizedBox(height: 10),
                      PlainText(
                        name: "Ordering Overview",
                        fontsize: 16,
                        color: textColor,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: buildContainer(
                                "Pending Order", 11, 80, orderingGradientColor),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: buildContainer(
                                "Confirm Order", 20, 80, orderingGradientColor),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: buildContainer("Delivered Order", 40, 80,
                                orderingGradientColor),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: buildContainer("Cancelled Order", 09, 83,
                                orderingGradientColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      PlainText(
                        name: "Business Overview",
                        fontsize: 16,
                        color: textColor,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: buildContainer("Today's Ordering", 20, 162,
                                businessGradientColor),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: buildContainer("Monthly Ordering", 80, 162,
                                businessGradientColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      PlainText(
                        name: "Payment Overview",
                        fontsize: 16,
                        color: textColor,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: buildContainer("Today's Ordering", 20, 162,
                                paymentGradientColor),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: buildContainer("Monthly Ordering", 80, 162,
                                paymentGradientColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.4,
              child: Container(
                  height: 40,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(199, 0, 0, 0),
                  ),
                  child: const Center(
                      child: Text(
                    "This Page is under Development",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )))),
        ],
      ),
    );
  }

  buildContainer(String text, int size, double width, List<Color> colors) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // color: color,
      ),
      height: 95,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PlainText(
            name: text,
            fontsize: 18,
            color: whiteColor,
            textAlign: TextAlign.center,
          ),
          PlainText(name: size.toString(), fontsize: 18, color: blackColor),
        ],
      ),
    );
  }
}
