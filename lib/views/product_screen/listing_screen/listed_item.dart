// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/listing_screen/listed_item_details.dart';

class ListedItemCategory extends StatefulWidget {
  const ListedItemCategory({super.key});

  @override
  State<ListedItemCategory> createState() => _ListedItemCategoryState();
}

class _ListedItemCategoryState extends State<ListedItemCategory> {
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
                        leading: Icon(
                          Icons.arrow_back_ios_new,
                          color: whiteColor,
                          size: 15,
                        ),
                        title: PlainText(
                          name: "Bag",
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
                  Container(
                      height: 600,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                          itemCount: bags.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(() => ListedItemDetails());
                                  },
                                  child: PlainText(
                                      name: bags[index], fontsize: 18)),
                            );
                          })),
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
    );
  }
}
