// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/all_tickets.dart';

class MarketplaceCancellationRequests extends StatefulWidget {
  const MarketplaceCancellationRequests({super.key});

  @override
  State<MarketplaceCancellationRequests> createState() =>
      _MarketplaceCancellationRequestsState();
}

class _MarketplaceCancellationRequestsState
    extends State<MarketplaceCancellationRequests> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "My Tickets",
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: w,
                  decoration: BoxDecoration(color: blackColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlainText(
                        name: "Create New Tickets",
                        fontsize: 16,
                        color: whiteColor,
                      ),
                      wSpacer(w * 0.45),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.close,
                          color: whiteColor,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: blueColor,
                        ),
                      ),
                      wSpacer(w * 0.034),
                      PlainText(
                        name: "Marketplace cancellation requests",
                        fontsize: 18,
                        color: blueColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlainText(name: "Title", fontsize: 18),
                        hSpacer(10),
                        TextFormField(
                          controller: titleController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        hSpacer(10),
                        PlainText(name: "Issue Description", fontsize: 18),
                        hSpacer(10),
                        TextFormField(
                          maxLines: 10,
                          controller: descController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                        hSpacer(10),
                      ],
                    ),
                  ),
                ),
                hSpacer(20),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 193,
                    child: RoundedButton(
                      title: "Send",
                      onTap: () {
                        Get.to(() => AllTickets());
                      },
                      radius: 25,
                    ),
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
}
