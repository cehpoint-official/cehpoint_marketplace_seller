// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/request_call.dart';

class Viewticket extends StatefulWidget {
  const Viewticket(
      {super.key,
      required this.email,
      required this.date,
      required this.time,
      required this.desc,
      required this.reply,
      required this.title,
      required this.userUrl,
      required this.uid,
      required this.username,
      required this.ticketId});
  final String email;
  final String title;
  final String date;
  final String time;
  final String desc;
  final String reply;
  final String userUrl;
  final String uid;
  final String username;
  final String ticketId;

  @override
  State<Viewticket> createState() => _ViewticketState();
}

class _ViewticketState extends State<Viewticket> {
  bool flag = false;
  String status = "Your Issue is pending";
  @override
  void initState() {
    if (widget.reply == "") {
      flag = false;
    } else {
      flag = true;
      status = "Your Issue is solved";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ticketId);
    return Scaffold(
        drawer: Pdrawer(
          email: widget.email,
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text(
            "Support",
            style: TextStyle(color: Colors.white),
          ),
          leading: Builder(builder: (BuildContext builderContext) {
            return InkWell(
              onTap: () {
                Scaffold.of(builderContext).openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: whiteColor,
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => RequestCall(
                        email: widget.email,
                        username: widget.username,
                      ));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.headphones,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Help",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 25, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: appColor,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1)),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.userUrl),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: SelectableText(
                        'You',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                SelectableText(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    fontSize: 22,
                  ),
                ),
                SelectableText(
                  "${widget.date},${widget.time}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 15,
                ),

                // Description
                SelectableText(
                  widget.desc,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SelectableText(
                  'Item ID: ${widget.uid}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                SelectableText(
                  'Ticket ID: ${widget.ticketId}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 25,
                ),
                if (flag)
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: appColor,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)),
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Cehpoint Marketplace',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                SelectableText(
                  widget.reply,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 230,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: flag ? Colors.green : Colors.orange,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: SelectableText(
                        "$status!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: flag ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
