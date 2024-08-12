import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/new_listing.dart';

// ignore: must_be_immutable
class NewListingConfirmationPage extends StatefulWidget {
  String docID;
  String email;
  String username;
  NewListingConfirmationPage(
      {super.key,
      required this.docID,
      required this.email,
      required this.username});

  @override
  State<NewListingConfirmationPage> createState() =>
      _NewListingConfirmationPageState();
}

class _NewListingConfirmationPageState
    extends State<NewListingConfirmationPage> {
  String price = "";
  String rooms = "";
  String title = "";
  String imageURL = "";
  String location = "";
  String reraID = "";
  String postBy = "";
  String postDate = "";

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.email)
          .collection('Seller_Property')
          .doc(widget.docID)
          .get()
          .then((value) {
        setState(() {
          int intprice = (value['Selling Price (INR)']).toInt();
          price = formatAmount(intprice.toString());
          title = value['Title'];
          try {
            imageURL = value['Images'][0];
          } catch (e) {
            imageURL =
                "https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/avatar%2FAvatar_Property.png?alt=media&token=571a9f00-0f39-416a-a00e-8cd1aa592ca9";
          }
          location = '${value['Plot Number']}, ${value['Locality']}';
          reraID = value['Rera ID'];
          postBy = value['Post By'];
          Timestamp ts = value['Post Date'] as Timestamp;
          postDate = formatTimestamp(ts);
        });
      }).onError((error, stackTrace) {});
    } catch (e) {
      if (kDebugMode) {
        print("CATCHED ERROR : $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08215E),
        title: const PlainText(
          name: "New Listing",
          fontsize: 20,
          color: Colors.white,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(72, 76, 175, 79),
                    border: Border.all(color: Colors.green)),
                child: const Wrap(
                  children: [
                    Text(
                      "Congratulation! Listing has been created successfully",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 54, 133, 57),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Listing Details",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    imageURL,
                    height: 150,
                    width: 150,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                ),
              ),
              Text(
                '$price | $rooms $title',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
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
                    location,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Posted on $postDate, by $postBy",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 100, 100, 100)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Rera ID: $reraID",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14, color: Color.fromARGB(255, 100, 100, 100)),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(104, 203, 85, 0),
                    border: Border.all(
                      color: const Color.fromARGB(255, 203, 85, 0),
                    )),
                child: const Wrap(
                  children: [
                    Text(
                      "Newly created listing is under Quality check",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 181, 76, 0),
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              color: Color.fromARGB(255, 214, 214, 214))
        ]),
        child: BottomAppBar(
          height: 70,
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(HomeScreenProperty(
                      email: widget.email,
                    ));
                  },
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: const WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    "View Listing",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )),
                ),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(NewListing(
                      email: widget.email,
                      username: widget.username,
                    ));
                  },
                  style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: const Center(
                      child: Text(
                    "Create Listing",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatAmount(String source) {
    int amount = int.parse(source);
    if (amount < 1000) {
      return 'INR ${amount.toString()}';
    } else if (amount < 100000) {
      double formattedAmount = amount / 1000.0;
      return 'INR ${formattedAmount.toStringAsFixed(2)} K';
    } else if (amount < 10000000) {
      double formattedAmount = amount / 100000.0;
      return 'INR ${formattedAmount.toStringAsFixed(2)} L';
    } else {
      double formattedAmount = amount / 10000000.0;
      return 'INR ${formattedAmount.toStringAsFixed(2)} Cr';
    }
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
