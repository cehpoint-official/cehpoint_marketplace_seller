// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/all_tickets.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/create_tickets.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/pending_tickets.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/resolved_tickets.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

var userName = "";

class _TicketScreenState extends State<TicketScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  int allticketquery = 2;
  int pendingticketquery = 1;
  int resolvedticketquery = 0;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    var name = auth.currentUser?.emailVerified;
    setState(() {
      userName = name.toString();
    });
    return Scaffold(
      // backgroundColor: whiteColor,
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
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: w,
                decoration: BoxDecoration(color: boxColor),
                child: TextFormField(
                  style: TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: whiteColor,
                    ),
                    hintText: "Enter incident ID",
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
              // BoldText(name: userName, fontsize: 50),
              hSpacer(5),
              Column(
                children: [
                  buildListTile(
                    "All Tickets ($allticketquery)",
                    () {
                      Get.to(() => AllTickets());
                    },
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 20,
                    color: greyColor,
                    thickness: 1.5,
                    height: 0,
                  ),
                  buildListTile(
                    "Pending Tickets ($pendingticketquery)",
                    () {
                      Get.to(() => PendingTickets());
                    },
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 20,
                    color: greyColor,
                    thickness: 1.5,
                    height: 0,
                  ),
                  buildListTile(
                    "Resolved/Closed Tickets ($resolvedticketquery)",
                    () {
                      Get.to(() => ResolvedTickets());
                    },
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 20,
                    color: greyColor,
                    thickness: 1.5,
                    height: 0,
                  ),
                ],
              ),
              hSpacer(20),
              Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 193,
                  child: RoundedButton(
                    title: "+ Create",
                    onTap: () {
                      Get.to(() => CreateTickets());
                    },
                    radius: 25,
                  ),
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

  buildListTile(String ticketType, VoidCallback onTap) {
    return ListTile(
      tileColor: whiteColor,
      onTap: onTap,
      title: PlainText(name: ticketType, fontsize: 17),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
