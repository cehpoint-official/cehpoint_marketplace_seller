// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/tickets/ticket_support.dart';

class ResolvedTickets extends StatefulWidget {
  const ResolvedTickets({super.key});

  @override
  State<ResolvedTickets> createState() => _ResolvedTicketsState();
}

var userName = "";

class _ResolvedTicketsState extends State<ResolvedTickets> {
  FirebaseAuth auth = FirebaseAuth.instance;
  int allticketquery = 2;
  int pendingticketquery = 1;
  int resolvedticketquery = 0;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    // var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteColor,
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
                child: TextFormField(
                  style: TextStyle(color: blackColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: greyColor),
                    hintText: "Enter incident ID / date",
                    hintStyle: TextStyle(
                      color: greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: whiteColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildIssueCard(
                        "Issue 2",
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam",
                        "Aug 01, 2023 , 01:35 PM",
                        "Resolved",
                        () {
                          Get.to(() => TicketSupport(status: "Resolved"));
                        },
                      ),
                      buildIssueCard(
                        "Issue 5",
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam",
                        "Aug 09, 2023 , 11:35 AM",
                        "Resolved",
                        () {
                          Get.to(() => TicketSupport(status: "Resolved"));
                        },
                      ),
                    ],
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

  buildIssueCard(String issueNumber, String desc, String dateTime,
      String resolution, VoidCallback? onTap) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Card(
        color: whiteColor,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText(name: issueNumber, fontsize: 18),
              PlainText(
                name: desc,
                fontsize: 14,
                fontWeight: FontWeight.w300,
              ),
              hSpacer(w * 0.034),
              Row(
                children: [
                  Icon(Icons.calendar_month),
                  wSpacer(5),
                  PlainText(
                    name: dateTime,
                    fontsize: 14,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 20,
                  width: 68,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: resolution == "Pending"
                              ? orangeColor
                              : greenColor)),
                  child: Center(
                      child: PlainText(
                    name: resolution,
                    fontsize: 10,
                    color: resolution == "Pending" ? orangeColor : greenColor,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
