// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/reusable_textfield.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';

class CreateNewListing extends StatefulWidget {
  const CreateNewListing({super.key});

  @override
  State<CreateNewListing> createState() => _CreateNewListingState();
}

List<String> imagePaths = [];

class _CreateNewListingState extends State<CreateNewListing> {
  TextEditingController sellerSkuID = TextEditingController();

  Future<void> pickImage(ImageSource imgSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imgSource);

    if (pickedFile != null) {
      setState(() {
        imagePaths.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
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
          Container(
            height: h - 100,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // width: 320,
                    alignment: Alignment.center,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/dottedborder.png"),
                          fit: BoxFit.fill),
                    ),
                    child: imagePaths.isEmpty
                        ? Image.asset(
                            "assets/images/bag3.png",
                            height: 184,
                            width: 130,
                          )
                        : Image.file(File(imagePaths[0])),
                  ),
                  hSpacer(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundedButton(
                      radius: 25,
                      title: "Upload Photos",
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext builderContext) {
                            return Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.244,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(25.0),
                                  topRight: const Radius.circular(25.0),
                                ),
                              ),
                              child: buildEventShareSheet(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  hSpacer(20),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imagePaths.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2),
                                child: Image.file(
                                  File(imagePaths[index]),
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 75,
                          width: 50,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Image.asset(
                            "assets/images/addImg.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hSpacer(10),
                  BoldText(
                    name: "Image Resolution",
                    fontsize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  hSpacer(5),
                  PlainText(
                    name:
                        "Use clear color image with minimum resolution of 500X500 px",
                    fontsize: 15,
                    color: greyColor,
                  ),
                  hSpacer(10),
                  PlainText(
                    name: "Seller SKU ID*",
                    fontsize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  hSpacer(5),
                  SizedBox(
                    height: 45,
                    child: ReusableTextField(
                      controller: sellerSkuID,
                    ),
                  ),
                  hSpacer(20),
                  BoldText(
                    name:
                        "Follow Image Guidelines to reduce the Quality Check failures",
                    fontsize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  buildGuidelineContainer(
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                  ),
                  buildGuidelineContainer(
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                  ),
                  buildGuidelineContainer(
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                  ),
                  buildGuidelineContainer(
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Facere expedita quibusdam assumenda explicabo omnis totam? Voluptatem tenetur nisi error beatae veniam, illo velit eaque quidem, quam ratione quaerat repudiandae placeat",
                  ),
                  RoundedButton(
                    title: "Confirm & Next",
                    onTap: () {},
                    radius: 0,
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
    );
  }

  buildGuidelineContainer(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 75,
      // width: 330,
      // decoration: BoxDecoration(border: Border.all()),
      child: PlainText(
        textAlign: TextAlign.justify,
        name: text,
        fontsize: 14,
      ),
    );
  }

  Widget buildEventShareSheet() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () => Get.back(), child: Icon(Icons.close, size: 25)),
          ),
          BoldText(
            name: "Upload a picture of your product",
            fontsize: 16,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableImageOption(Icons.image_rounded, "Gallery", () {
                  pickImage(ImageSource.gallery);
                }),
                reusableImageOption(Icons.camera_alt_rounded, "Camera", () {
                  pickImage(ImageSource.camera);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget reusableImageOption(IconData icon, String text, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: blueColor,
          ),
          PlainText(name: text, fontsize: 16),
        ],
      ),
    );
  }
}
