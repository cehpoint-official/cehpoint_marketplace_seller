// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';

class Listing extends StatefulWidget {
  const Listing({super.key});

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Listing",
          fontWeight: FontWeight.w400,
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.menu,
            color: whiteColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Get.to(() => FilterScreen());
            },
            child: Icon(
              Icons.add_box_rounded,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: () {
              // Get.to(() => NotificationScreen());
            },
            child: Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      height: 80,
                      width: w,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerHeight: 0,
                        indicatorWeight: 0,
                        labelPadding: const EdgeInsets.all(5),
                        controller: tabController,
                        indicatorPadding: const EdgeInsets.all(0),
                        tabs: [
                          buildTabBar("10", "Active Listings"),
                          buildTabBar("09", "Ready to Activation"),
                          buildTabBar("05", "Blocked Listings"),
                          buildTabBar("15", "Inactive Listings"),
                          buildTabBar("20", "Archieved Listings"),
                        ],
                        dividerColor: blackColor,
                        labelColor: blueColor,
                        padding: const EdgeInsets.all(0),
                        indicatorColor: appColor,
                        unselectedLabelColor: blackColor,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          // border: Border.all(),
                          // color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_box_outlined,
                              color: blueColor,
                            ),
                            PlainText(
                              name: "Select",
                              fontsize: 18,
                              color: blueColor,
                            ),
                            const SizedBox(width: 70),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: orangeColor,
                                border: Border.all(color: orangeColor),
                              ),
                              child: Icon(
                                Icons.swap_horiz_outlined,
                                color: whiteColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.filter_alt_outlined,
                              color: blueColor,
                            ),
                            PlainText(
                              name: "Filter",
                              fontsize: 18,
                              color: blueColor,
                            ),
                            const SizedBox(width: 20),
                            Icon(
                              Icons.sort_rounded,
                              color: blueColor,
                            ),
                            PlainText(
                              name: "Sort",
                              fontsize: 18,
                              color: blueColor,
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * 0.72,
                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          controller: tabController,
                          children: [
                            SizedBox(
                              height: h * 0.67,
                              child: buildProductTab(3),
                            ),
                            SizedBox(
                              height: h * 0.67,
                              child: buildProductTab(3),
                            ),
                            SizedBox(
                              height: h * 0.67,
                              child: buildProductTab(3),
                            ),
                            SizedBox(
                              height: h * 0.67,
                              child: buildProductTab(3),
                            ),
                            SizedBox(
                              height: h * 0.67,
                              child: buildProductTab(3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

  Widget buildProductTab(int itemCount) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
              height: 220,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            "assets/images/service.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BoldText(
                                name: "Lorem ipsum door sit amet\n consec"
                                    "tetur adpisiscing",
                                fontsize: 14),
                            PlainText(
                              name: "Classic Cleaning Home\n"
                                  "ABCD:F-R-Dp-016",
                              fontsize: 13,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            PlainText(
                                name: "Listing Date:02/12/2023", fontsize: 15),
                            SizedBox(width: 10),
                            BoldText(name: "Time:1hrs", fontsize: 17),
                            SizedBox(width: 10),
                            BoldText(
                                name: "Listing Price:INR1500", fontsize: 17),
                            SizedBox(width: 10),
                            BoldText(name: "Final Price:INR1500", fontsize: 17),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTabBar(String count, String label) {
    return SizedBox(
      // width: 100,
      height: 70,
      // color: appColor,
      child: Tab(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PlainText(
              name: count,
              fontsize: 15,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            BoldText(
              name: label,
              fontsize: 12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
