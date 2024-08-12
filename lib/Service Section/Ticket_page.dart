// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:get/get.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
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
            Get.back();
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
          const SizedBox(width: 5),
          PlainText(
            name: "Help",
            fontsize: 14,
            color: whiteColor,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Positioned(
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
      ),
    );
  }
}
