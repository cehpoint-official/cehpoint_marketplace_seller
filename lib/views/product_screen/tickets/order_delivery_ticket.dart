// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/marketplace_cancellation_requests.dart';

class OrderAndDeliveryTickets extends StatefulWidget {
  const OrderAndDeliveryTickets({super.key});

  @override
  State<OrderAndDeliveryTickets> createState() =>
      _OrderAndDeliveryTicketsState();
}

class _OrderAndDeliveryTicketsState extends State<OrderAndDeliveryTickets> {
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
                        name: "Order & Delivery",
                        fontsize: 18,
                        color: blueColor,
                      ),
                    ],
                  ),
                ),
                buildListTile(
                  "Marketplace cancellation requests ",
                  () {
                    Get.to(() => MarketplaceCancellationRequests());
                  },
                ),
                buildListTile(
                  "I have been overcharged due to incorrect weight",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Showing false pick up reattempt",
                  () => Get.to(()),
                ),
                buildListTile(
                  "RTD breaches query / complaint",
                  () => Get.to(()),
                ),
                buildListTile(
                  "My orders are not yet picked up",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Why my order is On Hold and not moved to ‘New Orders’ tab?",
                  () => Get.to(()),
                ),
                buildListTile(
                  "My order status did not change after handover",
                  () => Get.to(()),
                ),
                buildListTile(
                  "My order is stuck in processing / unable to process order",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Issues in generating lable",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Others",
                  () => Get.to(()),
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

  buildListTile(String ticketType, VoidCallback onTap) {
    return ListTile(
      tileColor: whiteColor,
      onTap: onTap,
      title: PlainText(name: ticketType, fontsize: 17),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
