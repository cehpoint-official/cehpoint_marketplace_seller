// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Set<int> categoryIndexes = <int>{};
  Set<int> sortIndexes = <int>{};

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: PlainText(
            name: "Filter",
            fontsize: 18,
            color: pinkColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                sortIndexes.clear();
                categoryIndexes.clear();
              });
            },
            child: PlainText(
              name: "Reset",
              fontsize: 18,
              color: pinkColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(name: "Location", fontsize: 19),
                SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Choose Location",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: BorderSide(color: greyColor)),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  height: 2,
                ),
                SizedBox(height: 5),
                BoldText(name: "Category", fontsize: 19),
                SizedBox(
                  height: 160,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 2,
                    ),
                    itemCount: filterEvent.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      bool isSelected = categoryIndexes.contains(index);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              categoryIndexes.remove(index);
                            } else {
                              categoryIndexes.add(index);
                            }
                          });
                        },
                        child: Card(
                          elevation: 1,
                          color: isSelected ? orangeColor : whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              filterEvent[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: isSelected ? whiteColor : blackColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  height: 1,
                ),
                SizedBox(height: 10),
                BoldText(name: "Sort", fontsize: 19),
                SizedBox(
                  height: 160,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 2,
                    ),
                    itemCount: filterEvent.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      bool isSelected = sortIndexes.contains(index);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              sortIndexes.remove(index);
                            } else {
                              sortIndexes.add(index);
                            }
                          });
                        },
                        child: Card(
                          elevation: 1,
                          color: isSelected ? orangeColor : whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              filterEvent[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: isSelected ? whiteColor : blackColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 5),
                Divider(
                  height: 1,
                ),
                SizedBox(height: 10),
                BoldText(name: "Availability", fontsize: 19),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: greyColor),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(15),
                  child: Row(children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 5),
                    PlainText(name: "choose date", fontsize: 14),
                  ]),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: w,
            height: 60,
            decoration: BoxDecoration(
              color: categoryIndexes.isNotEmpty || sortIndexes.isNotEmpty
                  ? pinkColor
                  : Colors.grey.shade200,
            ),
            child: Center(
                child: PlainText(
              name: "Apply Filter",
              fontsize: 17,
              color: categoryIndexes.isNotEmpty || sortIndexes.isNotEmpty
                  ? whiteColor
                  : blackColor,
            )),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
