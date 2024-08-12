// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/listing_screen/check_brand_listing.dart';

class ListedItemDetails extends StatefulWidget {
  const ListedItemDetails({super.key});

  @override
  State<ListedItemDetails> createState() => _ListedItemDetailsState();
}

class _ListedItemDetailsState extends State<ListedItemDetails> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "New Listing",
          fontsize: 20,
          color: whiteColor,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: whiteColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: h - 90,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 60,
                      width: w,
                      color: appColor,
                      child: ListTile(
                        tileColor: Color(0xFF0C2769),
                        leading: Icon(
                          Icons.arrow_back_ios_new,
                          color: whiteColor,
                          size: 15,
                        ),
                        title: PlainText(
                          name: "School Bag",
                          fontsize: 18,
                          color: whiteColor,
                        ),
                        trailing: Icon(
                          Icons.close,
                          color: whiteColor,
                          size: 18,
                        ),
                      )),
                  hSpacer(10),
                  Row(
                    children: [
                      Image.asset("assets/images/bag2.png"),
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(name: "School Bag", fontsize: 20),
                            PlainText(
                              name:
                                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis.",
                              fontsize: 14,
                              color: greyColor,
                            )
                          ],
                        ),
                      )
                    ],
                  )
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
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedButton(
            title: "Search Again",
            onTap: () {},
            buttonColor: whiteColor,
            textColor: blackColor,
            borderColor: greyColor,
            radius: 0,
          ),
          RoundedButton(
            title: "Confirm and Next",
            onTap: () {
              Get.to(() => CheckBrandListing());
            },
            radius: 0,
          ),
        ],
      ),
    );
  }
}
