// ignore_for_file: unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/edit_listing_property.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// ignore: must_be_immutable
class ListingDetailedPage extends StatefulWidget {
  QueryDocumentSnapshot<Object?> documentSnapshot;
  String email;
  String username;
  ListingDetailedPage(
      {super.key,
      required this.documentSnapshot,
      required this.email,
      required this.username});

  @override
  State<ListingDetailedPage> createState() => _ListingDetailedPageState();
}

class _ListingDetailedPageState extends State<ListingDetailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 221, 221),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: const PlainText(
          name: "Your Listing",
          fontsize: 20,
          color: Colors.white,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(PropertyEditPage(
                  email: widget.email,
                ));
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll:
                  (widget.documentSnapshot['Images'].length > 1) ? true : false,
              reverse: false,
              autoPlay:
                  (widget.documentSnapshot['Images'].length > 1) ? true : false,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {},
            ),
            items: widget.documentSnapshot['Images'].map<Widget>((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.documentSnapshot['Title'],
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${widget.documentSnapshot['Plot Number']}, ${widget.documentSnapshot['Locality']}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Posted on ${formatTimestamp(widget.documentSnapshot['Post Date'])}, by ${widget.documentSnapshot['Post By']}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 100, 100, 100)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Rera ID: ${widget.documentSnapshot['Rera ID']}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 100, 100, 100)),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Price",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'INR ${widget.documentSnapshot['Selling Price (INR)']}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "AGENT",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${widget.documentSnapshot['Agent Name']}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                ZegoSendCallInvitationButton(
                  onPressed: (code, message, p2) async {
                    DateTime nowTime = DateTime.now();
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.email)
                        .collection('Call History')
                        .doc()
                        .set({
                      'Name': widget.documentSnapshot['Agent Name'],
                      'CallID': widget.documentSnapshot['Agent Email'],
                      'Direction': "Outgoing",
                      'Date-Time': nowTime,
                      'User Type': "Agents"
                    });
                    await FirebaseFirestore.instance
                        .collection('Agents')
                        .doc(widget.documentSnapshot['Agent Email'])
                        .collection('Call History')
                        .doc()
                        .set({
                      'Name': widget.username,
                      'CallID': widget.email,
                      'Direction': "Incoming",
                      'Date-Time': nowTime,
                      'User Type': "Seller"
                    });
                    setState(() {});
                  },
                  notificationTitle: widget.documentSnapshot['Seller Name'],
                  notificationMessage: "Seller is calling you",
                  buttonSize: const Size(50, 50),
                  icon: ButtonIcon(icon: const Icon(Icons.call)),
                  iconSize: const Size(50, 50),
                  isVideoCall: false,
                  resourceID: "zego_sokoni",
                  invitees: [
                    ZegoUIKitUser(
                      id: widget.documentSnapshot['Agent Email'],
                      name: widget.documentSnapshot['Agent Name'],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: (widget.documentSnapshot['Quality Check'] == "Pending")
                    ? Colors.amberAccent
                    : (widget.documentSnapshot['Quality Check'] == "Pass")
                        ? const Color.fromARGB(255, 101, 216, 122)
                        : Colors.redAccent,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      "Quality Check",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.documentSnapshot['Quality Check'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ]),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Property Details",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                propertyDetailsElement("Covered Area",
                    '${widget.documentSnapshot['Covered Area (sqft)']} sqft'),
                propertyDetailsElement(
                    "Category", widget.documentSnapshot['Category']),
                propertyDetailsElement("Listing Status",
                    widget.documentSnapshot['Listing Status']),
                propertyDetailsElement(
                    "Property Type", widget.documentSnapshot['Property Type']),
                ...widget.documentSnapshot['Features'].entries
                    .map<Widget>((MapEntry<dynamic, dynamic> entry) {
                  return propertyDetailsElement(entry.key, entry.value);
                }).toList(),
                propertyDetailsElement("Water Availability",
                    '${widget.documentSnapshot['Water Availablity']} hours'),
                propertyDetailsElement("Electricity Availability",
                    '${widget.documentSnapshot['Electricity Availablity']} hours'),
                propertyDetailsElement(
                    "Loan Offered By", widget.documentSnapshot['Bank']),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Amenities",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: [
                  ...widget.documentSnapshot['Services'].map<Widget>((entry) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 214, 214, 214),
                      ),
                      child: Text(entry),
                    );
                  }).toList(),
                ],
              )
            ]),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Property Description",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.documentSnapshot['Description'],
                style: const TextStyle(fontSize: 15),
              ),
            ]),
          ),
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Disclaimer",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.documentSnapshot['Disclaimer'],
                style: const TextStyle(fontSize: 15),
              ),
            ]),
          ),
          const SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }

  Widget propertyDetailsElement(String name, String data) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 85, 85, 85)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate =
        "${_getMonth(dateTime.month)} ${dateTime.day}', ${dateTime.year % 100}";
    return formattedDate;
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}
