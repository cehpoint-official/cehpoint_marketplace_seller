// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen>
    with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: PlainText(
          name: "Payments",
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
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 0),
                height: 50,
                decoration: BoxDecoration(color: appColor),
                child: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(child: BoldText(name: "Overview", fontsize: 16)),
                    Tab(
                        child:
                            BoldText(name: "Previous Payments", fontsize: 16)),
                  ],
                  dividerColor: Colors.transparent,
                  labelColor: whiteColor,
                  unselectedLabelColor: whiteColor,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: orangeColor,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: -16.0),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    //tab 1
                    buildOverViewTab(),
                    //tab 1
                    buildPreviousPayments(),
                  ],
                ),
              ),
            ],
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

  Widget buildPreviousPayments() {
    var w = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                color: whiteColor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: sellColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.call_received,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(width: w * 0.05),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlainText(
                              name: "Received From Cehpoint Marketplace",
                              fontsize: 14),
                          PlainText(name: "02Aug, 2023", fontsize: 13),
                        ],
                      ),
                      SizedBox(width: w * 0.05),
                      BoldText(name: "INR17,000", fontsize: 16),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget buildOverViewTab() {
    return ListView.builder(
      itemCount: paymentOption.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Card(
            // height: 148,
            // width: w,
            // color: whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(
                    name: paymentOption[index],
                    fontsize: 16,
                  ),
                  SizedBox(height: 5),
                  PlainText(
                    name: paymentdOptionDetails[index],
                    color: Colors.grey.shade700,
                    fontsize: 16,
                  ),
                  SizedBox(height: 10),
                  PlainText(
                    name: "Postpaid/TDS",
                    fontsize: 16,
                    color: greyColor,
                  ),
                  BoldText(
                    name: "INR4000",
                    fontsize: 16,
                  ),
                  SizedBox(height: 10),
                  PlainText(
                    name: "Postpaid/TDS",
                    fontsize: 16,
                    color: greyColor,
                  ),
                  BoldText(
                    name: "INR4000",
                    fontsize: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
