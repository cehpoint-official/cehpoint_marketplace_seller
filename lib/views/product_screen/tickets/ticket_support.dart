// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class TicketSupport extends StatefulWidget {
  final String status;
  const TicketSupport({super.key, required this.status});

  @override
  State<TicketSupport> createState() => _TicketSupportState();
}

class _TicketSupportState extends State<TicketSupport> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF08215E),
          title: PlainText(
            name: "Support",
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            child: Image.asset(
                              "assets/images/shop-circle.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        wSpacer(w * 0.034),
                        PlainText(name: "You", fontsize: 15)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldText(name: "Issue 1", fontsize: 18),
                        hSpacer(w * 0.034),
                        Row(
                          children: [
                            Icon(Icons.calendar_month),
                            wSpacer(5),
                            PlainText(
                              name: "Aug 02, 2023 , 11:35 AM",
                              fontsize: 14,
                            ),
                          ],
                        ),
                        hSpacer(w * 0.034),
                        PlainText(
                          name:
                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          fontsize: 13,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    hSpacer(w * 0.034),
                    BoldText(
                      name: "Item ID: 4678899808009",
                      fontsize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    BoldText(
                      name: "Item ID: 4678899808009",
                      fontsize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    hSpacer(w * 0.09),
                    Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundColor: appColor,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        wSpacer(w * 0.034),
                        PlainText(name: "Cehpoint Marketplace", fontsize: 15)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hSpacer(w * 0.034),
                        PlainText(
                          name:
                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          fontsize: 13,
                          textAlign: TextAlign.justify,
                        ),
                        hSpacer(w * 0.034),
                        PlainText(
                          name:
                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat.",
                          fontsize: 13,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    hSpacer(w * 0.034),
                    RoundedButton(
                      title: "Your Issue is ${widget.status}",
                      onTap: () {},
                      buttonColor: whiteColor,
                      borderColor:
                          widget.status == "Pending" ? orangeColor : greenColor,
                      textColor:
                          widget.status == "Pending" ? orangeColor : greenColor,
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
        ));
  }
}
