// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';

class ListingHomeScreen extends StatefulWidget {
  const ListingHomeScreen({super.key});

  @override
  State<ListingHomeScreen> createState() => _ListingHomeScreenState();
}

class _ListingHomeScreenState extends State<ListingHomeScreen>
    with TickerProviderStateMixin {
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
        backgroundColor: Color(0xFF08215E),
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
          SizedBox(width: 15),
          InkWell(
            onTap: () {
              // Get.to(() => NotificationScreen());
            },
            child: Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
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
                      labelPadding: EdgeInsets.all(5),
                      controller: tabController,
                      indicatorPadding: EdgeInsets.all(0),
                      tabs: [
                        buildTabBar("10", "Active Listings"),
                        buildTabBar("09", "Ready to Activation"),
                        buildTabBar("05", "Blocked Listings"),
                        buildTabBar("15", "Inactive Listings"),
                        buildTabBar("20", "Archieved Listings"),
                      ],
                      dividerColor: blackColor,
                      labelColor: blueColor,
                      padding: EdgeInsets.all(0),
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
                          SizedBox(width: 70),
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
                          SizedBox(width: 10),
                          Icon(
                            Icons.filter_alt_outlined,
                            color: blueColor,
                          ),
                          PlainText(
                            name: "Filter",
                            fontsize: 18,
                            color: blueColor,
                          ),
                          SizedBox(width: 20),
                          Icon(
                            Icons.sort_rounded,
                            color: blueColor,
                          ),
                          PlainText(
                            name: "Sort",
                            fontsize: 18,
                            color: blueColor,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 520,
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        controller: tabController,
                        children: [
                          //tab 1
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      BoldText(
                                          name: "Product Details",
                                          fontsize: 15),
                                      SizedBox(width: 70),
                                      BoldText(name: "Date", fontsize: 15),
                                      SizedBox(width: 50),
                                      BoldText(
                                          name: "Listing Price", fontsize: 15),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.65,
                                child: buildProductTab(10),
                              ),
                            ],
                          ),

                          //tab 2
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      BoldText(
                                          name: "Product Details",
                                          fontsize: 15),
                                      SizedBox(width: 70),
                                      BoldText(name: "Date", fontsize: 15),
                                      SizedBox(width: 50),
                                      BoldText(
                                          name: "Listing Price", fontsize: 15),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.65,
                                child: buildProductTab(4),
                              ),
                            ],
                          ),

                          //tab 3
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      BoldText(
                                          name: "Product Details",
                                          fontsize: 15),
                                      SizedBox(width: 70),
                                      BoldText(name: "Date", fontsize: 15),
                                      SizedBox(width: 50),
                                      BoldText(
                                          name: "Listing Price", fontsize: 15),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.65,
                                child: buildProductTab(2),
                              ),
                            ],
                          ),

                          //tab 4
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      BoldText(
                                          name: "Product Details",
                                          fontsize: 15),
                                      SizedBox(width: 70),
                                      BoldText(name: "Date", fontsize: 15),
                                      SizedBox(width: 50),
                                      BoldText(
                                          name: "Listing Price", fontsize: 15),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.65,
                                child: buildProductTab(5),
                              ),
                            ],
                          ),

                          //tab 5
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      BoldText(
                                          name: "Product Details",
                                          fontsize: 15),
                                      SizedBox(width: 70),
                                      BoldText(name: "Date", fontsize: 15),
                                      SizedBox(width: 50),
                                      BoldText(
                                          name: "Listing Price", fontsize: 15),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.65,
                                child: buildProductTab(6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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

  Widget buildProductTab(int itemCount) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        controller: scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 0),
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/images/bag.png"),
                      ),
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldText(name: "School Bags For Kids", fontsize: 14),
                          PlainText(
                            name: "ABCD: F-R-Dp-016",
                            fontsize: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  PlainText(name: "02/12/2023", fontsize: 15),
                  SizedBox(width: 10),
                  PlainText(name: "INR500", fontsize: 17),
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
            SizedBox(height: 5),
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
