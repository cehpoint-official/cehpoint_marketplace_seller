// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:get/get.dart';
import '../../common/bold_text.dart';

class Notification_page extends StatefulWidget {
  const Notification_page({super.key});

  @override
  State<Notification_page> createState() => _Notification_pageState();
}

class _Notification_pageState extends State<Notification_page>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Notifications(7)",
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
            onTap: () {},
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
          Container(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(child: PlainText(name: "All", fontsize: 20)),
                    Tab(child: PlainText(name: "Orders", fontsize: 20)),
                    Tab(child: PlainText(name: "Payment", fontsize: 20)),
                  ],
                  dividerColor: Colors.transparent,
                  labelColor: appColor,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: appColor,
                    ),
                    insets: const EdgeInsets.symmetric(horizontal: -16.0),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      //tab 1
                      listBuilder(),
                      //tab 2
                      listBuilder(),
                      //Tab3
                      listBuilder()
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
                )
              )
            )
          ),
        ],
      ),
    );
  }

  Widget listBuilder() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          // height: 148,
          // width: w,
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.task_outlined),
                    BoldText(
                      name: "New Order",
                      fontsize: 16,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: greenColor,
                        size: 10,
                      ),
                      PlainText(
                        name: "Today",
                        fontsize: 16,
                        color: greenColor,
                      ),
                    ],
                  ),
                ),
                const PlainText(
                  name:
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis ",
                  fontsize: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
