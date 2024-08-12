// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Advertising",
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
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 60,
                width: w,
                color: appColor,
                child: TextFormField(
                  style: TextStyle(color: whiteColor),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: whiteColor),
                    hintText: "Search Compaign",
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
              hSpacer(10),
              Row(
                children: [
                  BoldText(name: "Overall Performance", fontsize: 23),
                  RoundedButton(
                    title: "This Week",
                    onTap: () {},
                    textColor: whiteColor,
                    buttonColor: orangeColor,
                  ),
                ],
              )
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
}
