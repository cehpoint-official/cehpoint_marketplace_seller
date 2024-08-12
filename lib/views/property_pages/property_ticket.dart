// ignore_for_file: unused_import, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/allticket.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/avatarset.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/request_call.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/ticket_creation.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/ticketcountsetter.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/view_ticket.dart';

class Ticket1 extends StatefulWidget {
  const Ticket1({
    super.key,
    required this.email,
    required this.userurl,
    required this.username,
  });
  final String email;
  final String userurl;
  final String username;
  @override
  State<Ticket1> createState() => _Ticket1State();
}

class _Ticket1State extends State<Ticket1> {
  TextEditingController searchQuery = TextEditingController();
  // FocusNode _focusNode = FocusNode();
  // late Future<int> _countDataFuture;
  // late Future<int> _countDataFutureRes;
  // late Future<int> _countDataFuturePen;
  String state = "";
  String textcontrol = "";
  int length = 0;

  @override
  void initState() {
    super.initState();
    // _countDataFuture = countData("");
    // _countDataFutureRes = countData("resolved");
    // _countDataFuturePen = countData("pending");
  }

  @override
  Widget build(BuildContext context) {
    if (state == "true") {
      setState(() {});
    }
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      backgroundColor: const Color.fromRGBO(228, 228, 228, 1),
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
        child: Column(
          children: [
            Container(
              color: appColor,
              padding: const EdgeInsets.all(16.0),
              child: Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    // Set the value when the TextField is focused
                    setState(() {
                      textcontrol = "Value";
                    });
                  } else {
                    // Set the value back to initial when the TextField loses focus
                    setState(() {
                      textcontrol = "";
                    });
                  }
                },
                child: TextField(
                  controller: searchQuery,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      textcontrol = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: appColor,
                    hintText: 'Enter Ticket ID / date (yyyy-mm-dd)',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 250, 245, 245),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            if (textcontrol == "")
              const SizedBox(
                height: 20,
              ),
            if (textcontrol == "")
              Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 65,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<int>(
                  future: Ticketcountsetter.fetchAll(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'All Tickets',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                Get.to(() => Alltickets(
                                      email: widget.email,
                                      status: "",
                                      userUrl: widget.userurl,
                                      username: '',
                                    ));
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      int documentCount = snapshot.data ?? 0;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'All Tickets:($documentCount)',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                Get.to(() => Alltickets(
                                      email: widget.email,
                                      status: "",
                                      userUrl: widget.userurl,
                                      username: widget.username,
                                    ));
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            if (textcontrol == "")
              const SizedBox(
                height: 5,
              ),
            if (textcontrol == "")
              Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 65,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<int>(
                  future: Ticketcountsetter.fetchP(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Pending Tickets',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                Get.to(() => Alltickets(
                                    email: widget.email,
                                    status: "pending",
                                    userUrl: widget.userurl,
                                    username: widget.username));
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      int documentCount = snapshot.data ?? 0;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pending Tickets: ($documentCount)',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                Get.to(() => Alltickets(
                                    email: widget.email,
                                    status: "pending",
                                    userUrl: widget.userurl,
                                    username: widget.username));
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            if (textcontrol == "")
              const SizedBox(
                height: 5,
              ),
            if (textcontrol == "")
              Container(
                color: const Color.fromRGBO(255, 255, 255, 1),
                height: 65,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<int>(
                  future: Ticketcountsetter.fetchR(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Resolved / Closed',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                Get.to(() => Alltickets(
                                    email: widget.email,
                                    status: "resolved",
                                    userUrl: widget.userurl,
                                    username: widget.username));
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      int documentCount = snapshot.data ?? 0;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Resolved / Closed:($documentCount)',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                Get.to(() => Alltickets(
                                    email: widget.email,
                                    status: "resolved",
                                    userUrl: widget.userurl,
                                    username: widget.username));
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            if (textcontrol != "")
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.7,
                width: MediaQuery.sizeOf(context).width,
                child: CustomScrollView(
                  slivers: [
                    FutureBuilder(
                      future: fetchData(searchQuery.text, ""),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return SliverToBoxAdapter(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                String title =
                                    "${snapshot.data?[index]['title']}";
                                String desc =
                                    "${snapshot.data?[index]['description']}";
                                String date =
                                    "${snapshot.data?[index]['date']}";
                                String time =
                                    "${snapshot.data?[index]['time']}";
                                // String status = "${snapshot.data?[index]['status']}";
                                String reply =
                                    "${snapshot.data?[index]['Reply']}";
                                String uid =
                                    "${snapshot.data?[index]['Property UID']}";
                                String ticketID =
                                    "${snapshot.data?[index]['TicketId']}";
                                var flag = false;
                                String currentstatus = "";
                                if (reply == "") {
                                  flag = false;
                                  currentstatus = "Peding";
                                } else {
                                  flag = true;
                                  currentstatus = "Resolved";
                                }
                                //if reply is not empty set status to resolved
                                return ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  tileColor:
                                      const Color.fromARGB(255, 236, 236, 236),
                                  title: GestureDetector(
                                    onTap: () {
                                      Get.to(() => Viewticket(
                                            email: widget.email,
                                            title: title,
                                            date: date,
                                            time: time,
                                            desc: desc,
                                            reply: reply,
                                            userUrl: widget.userurl,
                                            uid: uid,
                                            username: widget.username,
                                            ticketId: ticketID,
                                          ));
                                    },
                                    child: Center(
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Title
                                              Text(
                                                title,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),

                                              // Category
                                              Text(
                                                'Desc: $desc',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                'TicketId: $ticketID',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),

                                              // Address
                                              Row(
                                                children: [
                                                  Text(
                                                    date,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    child: Text(","),
                                                  ),
                                                  Text(
                                                    time,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: flag
                                                          ? Colors.green
                                                          : Colors.orange,
                                                    ),
                                                    color: Colors.transparent,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "$currentstatus!",
                                                      style: TextStyle(
                                                        color: flag
                                                            ? Colors.green
                                                            : Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: snapshot.data?.length ?? 0,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            buildClickableContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildClickableContainer() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.to(() => Tcreate(
                email: widget.email,
                unsername: widget.username,
              ))?.then((result) {
            if (result != null) {
              setState(() {
                state = "true";
              });
              setState(() {});
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.40,
            // width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue,
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),

            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(width: 5.0),
                Text(
                  'Create',
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
    );
  }

  Future<List<Map<String, dynamic>>> fetchData(
      String searchQuery, String status) async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot<Map<String, dynamic>> alldocuments = await FirebaseFirestore
        .instance
        .collection('Property_Tickets')
        .doc(widget.email)
        .collection(widget.email)
        .get();

    Map<String, dynamic> documentsMap = {};
    for (QueryDocumentSnapshot documentSnapshot in alldocuments.docs) {
      documentsMap[documentSnapshot.id] = documentSnapshot.data();
    }
    documentsMap.forEach((documentId, itemData) {
      if (itemData['title'] != null) {
        if (status == "") {
          if (searchQuery == "") {
            data.add(itemData);
          } else {
            if (itemData['TicketId']
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ||
                itemData['date']
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase())) {
              data.add(itemData);
            }
          }
        } else if (status == "pending") {
          if (itemData['Reply'].toString() == "") {
            if (searchQuery == "") {
              data.add(itemData);
            } else {
              if (itemData['TicketId']
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  itemData['date']
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())) {
                data.add(itemData);
              }
            }
          }
        } else if (status == "resolved") {
          if (itemData['Reply'].toString() != "") {
            if (searchQuery == "") {
              data.add(itemData);
            } else {
              if (itemData['TicketId']
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()) ||
                  itemData['date']
                      .toString()
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())) {
                data.add(itemData);
              }
            }
          }
        }
      }
    });
    data.sort((a, b) => b['TicketId'].compareTo(a['TicketId']));
    return data;
  }

  // Future<int> countData(String status) async {
  //   List<Map<String, dynamic>> data = [];

  //   QuerySnapshot<Map<String, dynamic>> alldocuments = await FirebaseFirestore
  //       .instance
  //       .collection('Property_Tickets')
  //       .doc(widget.email)
  //       .collection(widget.email)
  //       .get();
  //   Map<String, dynamic> documentsMap = {};
  //   for (QueryDocumentSnapshot documentSnapshot in alldocuments.docs) {
  //     documentsMap[documentSnapshot.id] = documentSnapshot.data();
  //   }
  //   documentsMap.forEach((documentId, itemData) {
  //     if (itemData['title'] != null) {
  //       if (status == "") {
  //         data.add(itemData);
  //       } else if (status == "pending") {
  //         if (itemData['Reply'].toString() == "") {
  //           data.add(itemData);
  //         }
  //       } else if (status == "resolved") {
  //         if (itemData['Reply'].toString() != "") {
  //           data.add(itemData);
  //         }
  //       }
  //     }
  //   });
  //   return data.length;
  // }
}
