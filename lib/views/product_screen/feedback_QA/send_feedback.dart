// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class SendFeedBack extends StatefulWidget {
  const SendFeedBack({super.key});

  @override
  State<SendFeedBack> createState() => _SendFeedBackState();
}

class _SendFeedBackState extends State<SendFeedBack> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: PlainText(
          name: "Send feedback",
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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 60),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(border: Border.all(color: greyColor)),
                height: 415,
                width: w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 61,
                      width: w,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.star_outline,
                                color: yellowColor,
                                size: 50,
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                          color: greyColor1,
                          borderRadius: BorderRadius.circular(10)),
                      height: 150,
                      child: TextFormField(
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText:
                              "Write your words and suggestions to help us improve",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 63,
                    ),
                    SizedBox(
                      height: 63,
                      width: 200,
                      child: RoundedButton(
                        onTap: () {},
                        title: "Send",
                        radius: 35,
                        fontsize: 20,
                      ),
                    )
                  ],
                ),
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
