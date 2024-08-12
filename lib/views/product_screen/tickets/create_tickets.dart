// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/order_delivery_ticket.dart';

class CreateTickets extends StatefulWidget {
  const CreateTickets({super.key});

  @override
  State<CreateTickets> createState() => _CreateTicketsState();
}

class _CreateTicketsState extends State<CreateTickets> {
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    style: TextStyle(color: blackColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: greyColor,
                      ),
                      hintText: "Select an issue",
                      hintStyle: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.w400,
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: greyColor),
                      ),
                    ),
                  ),
                ),
                buildListTile(
                  "Order & Delivery",
                  () => Get.to(() => OrderAndDeliveryTickets()),
                ),
                buildListTile(
                  "Listing & Catalog",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Payments & Settlements",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Returns",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Seller Account Settings",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Seller Performance",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Promotions",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Product Listing Ads",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Report infringement / fake",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Others",
                  () => Get.to(()),
                ),
                buildListTile(
                  "Buyer Suspicious / fraud",
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
