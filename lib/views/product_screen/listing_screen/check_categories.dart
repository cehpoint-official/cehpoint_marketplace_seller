// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/listing_screen/listed_item.dart';

class CheckCategoriesScreen extends StatefulWidget {
  const CheckCategoriesScreen({super.key});

  @override
  State<CheckCategoriesScreen> createState() => _CheckCategoriesScreenState();
}

class _CheckCategoriesScreenState extends State<CheckCategoriesScreen> {
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 60,
                    width: w,
                    color: appColor,
                    child: TextFormField(
                      style: TextStyle(color: whiteColor),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: whiteColor),
                        hintText: "Search Category of a Product",
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlainText(
                          name: "Your Verticals",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        hSpacer(10),
                        SizedBox(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              buildCategoryContainer("Bag", () {
                                Get.to(() => ListedItemCategory());
                              }),
                              buildCategoryContainer("Phone", () {}),
                              buildCategoryContainer("Book", () {}),
                              buildCategoryContainer("Water Bottle", () {}),
                            ],
                          ),
                        ),
                        PlainText(
                          name: "All Categories",
                          fontsize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        hSpacer(10),
                        buildListTile("Phone", () {}),
                        buildListTile("Tablets", () {}),
                        buildListTile("Laptop", () {}),
                        buildListTile("Jwellery", () {}),
                        buildListTile("Stationary", () {}),
                        buildListTile("Electronics", () {}),
                        buildListTile("Cosmetics", () {}),
                        buildListTile("Learning Products", () {}),
                        buildListTile("Home Furniture", () {}),
                        buildListTile("Home & Kitchen appliances", () {}),
                      ],
                    ),
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
      ),
    );
  }

  buildListTile(String ticketType, VoidCallback onTap) {
    return ListTile(
      tileColor: whiteColor,
      onTap: onTap,
      title: PlainText(name: ticketType, fontsize: 17),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
    );
  }

  buildCategoryContainer(String name, VoidCallback ontap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: 31,
          decoration: BoxDecoration(border: Border.all()),
          alignment: Alignment.center,
          child: PlainText(name: name, fontsize: 16),
        ),
      ),
    );
  }
}
