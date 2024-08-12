// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';

class ReturnOrder extends StatefulWidget {
  const ReturnOrder({Key? key}) : super(key: key);

  @override
  State<ReturnOrder> createState() => _ReturnOrderState();
}

class _ReturnOrderState extends State<ReturnOrder>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  int upcomingOrder = 2;
  int completedOrder = 1;
  int quantity = 10;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: PlainText(
          name: "Return",
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
              // Get.to(() => NotificationScreen());
            },
            child: Icon(
              Icons.download,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 700,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 60,
                  width: w,
                  color: appColor,
                  child: TextFormField(
                    style: TextStyle(color: whiteColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: whiteColor),
                      hintText: "Enter Order ID/Item ID/Tracking ID",
                      hintStyle: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: whiteColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 610,
                  child: Column(
                    children: [
                      TabBar(
                        labelPadding: EdgeInsets.all(0),
                        controller: tabController,
                        tabs: [
                          Tab(
                              child:
                                  BoldText(name: "In-Progress", fontsize: 15)),
                          Tab(child: BoldText(name: "Completed", fontsize: 15)),
                        ],
                        indicatorColor: Colors.amber,
                        labelColor: appColor,
                        indicatorSize: TabBarIndicatorSize.label,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            buildOrderTab(upcomingOrder),
                            buildOrderTab(completedOrder),
                          ],
                        ),
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

  Widget buildOrderTab(int orderCount) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          PlainText(
            name: "$orderCount Orders",
            fontsize: 12,
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.grey.shade200,
            height: 520,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return buildOrderCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderCard() {
    var w = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        height: 180,
        width: w,
        decoration: BoxDecoration(color: whiteColor),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      "assets/images/bag.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  BoldText(name: "INR500", fontsize: 14),
                  PlainText(name: "Qty: $quantity", fontsize: 13),
                ],
              ),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PlainText(
                        name: "Approved",
                        fontsize: 14,
                        color: greenColor,
                      ),
                      SizedBox(width: 20),
                      PlainText(
                        name: "Prepaid",
                        fontsize: 14,
                        color: greyColor,
                      ),
                    ],
                  ),
                  PlainText(
                    name:
                        "School Bag For girl Kids| Pink School Bag | Doll Bag",
                    fontsize: 17,
                  ),
                  PlainText(name: "SKU ID: combo30", fontsize: 14),
                  PlainText(name: "Order ID: OD343566768787", fontsize: 14),
                  PlainText(name: "Order Date: Aug 05, 2023", fontsize: 14),
                  PlainText(name: "Dispatch after: Aug05, 2023", fontsize: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
