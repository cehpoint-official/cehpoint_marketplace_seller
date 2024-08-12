import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:intl/intl.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/request_call.dart';

class Tcreate extends StatefulWidget {
  const Tcreate({
    super.key,
    required this.email,
    required this.unsername,
  });
  final String email;
  final String unsername;

  @override
  State<Tcreate> createState() => _TcreateState();
}

class _TcreateState extends State<Tcreate> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController uid = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "My tickets",
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
                      username: widget.unsername,
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
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 65,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create New Ticket",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  Center(
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.blue,
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Marketplace cancellation requests",
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Title',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors
                              .black, // Change the color to your desired color
                        ),
                      ),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 1.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Property UiD',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .black, // Change the color to your desired color
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 1.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: TextFormField(
                controller: uid,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Issue Description',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors
                                .black, // Change the color to your desired color
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 1.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: TextFormField(
                controller: desc,
                minLines: 6,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  if (title.text != "" && desc.text != "" && uid.text != "") {
                    try {
                      DateTime currentDate = DateTime.now();
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(currentDate);
                      String docID = '${DateTime.now().millisecondsSinceEpoch}';
                      String formattedTime =
                          TimeOfDay.fromDateTime(currentDate).format(context);
                      FirebaseFirestore firestore = FirebaseFirestore.instance;

                      await firestore
                          .collection('Property_Tickets')
                          .doc(widget.email)
                          .collection(widget.email)
                          .doc(docID)
                          .set({
                        'title': title.text,
                        'description': desc.text,
                        'email': widget.email,
                        'status': "Pending",
                        'time': formattedTime,
                        'date': formattedDate,
                        'Reply': "",
                        'Property UID': uid.text,
                        'TicketId': docID
                      });

                      Utils().toastMessage("Ticket Created Successfully!");
                      // ignore: use_build_context_synchronously
                      Get.back(result: "true");
                      Get.to(HomeScreenProperty(email: widget.email));
                    } catch (e) {
                      Utils().toastMessage(e.toString());
                    }
                  } else {
                    Utils().toastMessage("Fill all the Fields");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
