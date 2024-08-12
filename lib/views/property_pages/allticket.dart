import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/request_call.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/view_ticket.dart';

class Alltickets extends StatefulWidget {
  const Alltickets(
      {super.key,
      required this.email,
      required this.status,
      required this.userUrl,
      required this.username});
  final String email;
  final String status;
  final String userUrl;
  final String username;

  @override
  State<Alltickets> createState() => _AllticketsState();
}

class _AllticketsState extends State<Alltickets> {
  TextEditingController searchQuery = TextEditingController();

  // String currentstatus="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Pdrawer(email: widget.email),
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
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
                child: TextField(
                  controller: searchQuery,
                  onChanged: (value) {
                    setState(() {});
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.75,
                width: MediaQuery.sizeOf(context).width,
                child: CustomScrollView(
                  slivers: [
                    FutureBuilder(
                      future: fetchData(searchQuery.text, widget.status),
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
                                            userUrl: widget.userUrl,
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
            ],
          ),
        ));
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
}
