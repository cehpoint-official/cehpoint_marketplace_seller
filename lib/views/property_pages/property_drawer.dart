// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cehpoint_marketplace_seller/auth/login_page.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/advertise_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/agents_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/calls_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/chats_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/avatarset.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/camera.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_feedback.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_ticket.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/sellmore.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/ticketcountsetter.dart';

class Pdrawer extends StatefulWidget {
  final String email;
  const Pdrawer({
    super.key,
    required this.email,
  });

  @override
  State<Pdrawer> createState() => _PdrawerState();
}

class _PdrawerState extends State<Pdrawer> {
  late final FirebaseFirestore _firestoree;
  final TextEditingController editUsername = TextEditingController();
  String user = "";
  String usernamee = "";
  String avatarurl = "";
  @override
  void initState() {
    super.initState();
    _fetchSellerDetails();
  }

  void _fetchSellerDetails() async {
    try {
      late FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot sellerDoc =
          await firestore.collection('users').doc(widget.email).get();

      if (sellerDoc.exists) {
        var displayName = sellerDoc.get('Display Name');
        var url = sellerDoc.get('Avatar');

        setState(() {
          editUsername.text = displayName;
          usernamee = displayName;
          avatarurl = url;
        });
      } else {
        debugPrint('Seller document not found!');
      }
    } catch (error) {
      debugPrint('Error fetching seller details: $error');
    }
  }

  void _updateDisplayName() async {
    try {
      _firestoree = FirebaseFirestore.instance;
      await _firestoree.collection('users').doc(widget.email).update({
        'Display Name': editUsername.text,
      });
      AvatarUrl.setUsername(editUsername.text);
      _fetchSellerDetails();
      Utils().toastMessage("Username Updated Successfully!");
    } catch (error) {
      Utils().toastMessage(error.toString());
    }
  }

  double drawerWidth = 200.0;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future logOut() async {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    try {
      await auth.signOut();
      Get.to(() => const LoginPage());
      Utils().toastMessage("Successfully Logged Out!");
    } catch (e) {
      Utils().toastMessage(e.toString());

      debugPrint('Failed to sign in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 304.0,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildHeader(context),
            const SizedBox(
              height: 25,
            ),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        color: appColor,
        padding: const EdgeInsets.only(top: 40, left: 10, bottom: 10),
        child: Row(
          children: [
            Stack(children: [
              Container(
                width: 85,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1)),
                  ],
                  shape: BoxShape.circle,
                  image: avatarurl != "" && avatarurl.isNotEmpty
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(avatarurl),
                        )
                      : DecorationImage(
                          // Default image or placeholder
                          fit: BoxFit.cover,
                          image: NetworkImage(AvatarUrl.fetch()),
                        ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      _showImageSourceOptions();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(Icons.camera_alt),
                    ),
                  )),
            ]),
            const SizedBox(width: 15),
            SizedBox(
              width: 304 - 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 304 - 160,
                        child: PlainText(
                          name: AvatarUrl.fetchUsername(),
                          fontsize: 22,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: editUsername,
                                              decoration: const InputDecoration(
                                                labelText: 'Edit Username',
                                              ),
                                            ),
                                            const SizedBox(height: 35.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: appColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (editUsername.text !=
                                                        "") {
                                                      _updateDisplayName();
                                                      setState(() {});

                                                      Navigator.pop(context);
                                                    } else {
                                                      Utils().toastMessage(
                                                          "Username Cannot be empty");
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: appColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                  ),
                                                  child: const Text('  Save  '),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  PlainText(
                    name: widget.email,
                    fontsize: 14,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const BoldText(
                name: "Home",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => HomeScreenProperty(
                      email: widget.email,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
              ),
              title: const BoldText(
                name: "Chats",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => MessagesProperty(
                      email: widget.email,
                      username: usernamee,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.call,
              ),
              title: const BoldText(
                name: "Calls",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => CallsProperty(
                      email: widget.email,
                      username: usernamee,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.man,
              ),
              title: const BoldText(
                name: "Agents",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => Agents(
                      email: widget.email,
                      username: usernamee,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_bag,
              ),
              title: const BoldText(
                name: "Sell More",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => Sellmore(
                      email: widget.email,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.tv,
              ),
              title: const BoldText(
                name: "Advertising",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => AdvertisingProperty(
                      email: widget.email,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.mail_outline_outlined,
              ),
              title: const BoldText(
                name: "My Tickets",
                fontsize: 16,
              ),
              onTap: () async {
                await Ticketcountsetter.countDataA("", widget.email);
                await Ticketcountsetter.countDataR("resolved", widget.email);
                await Ticketcountsetter.countDataP("pending", widget.email);
                Get.to(() => Ticket1(
                      email: widget.email,
                      userurl: avatarurl,
                      username: usernamee,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_outlined,
              ),
              title: const BoldText(
                name: "Send FeedBack",
                fontsize: 16,
              ),
              onTap: () {
                Get.to(() => PFeedback(
                      email: widget.email,
                    ));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const BoldText(
                name: "Log Out",
                fontsize: 16,
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: MediaQuery.sizeOf(context).height * 0.26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Center(
                                child: Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      foregroundColor: Colors.blue,
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      logOut();
                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      foregroundColor: Colors.blue,
                                      backgroundColor: Colors.white,
                                    ),
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );

                debugPrint('$auth.currentUser');
              },
            ),
          ],
        ),
      );
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 25,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      const Center(
                          child: Text(
                        "Upload a picture of your property",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                );

                                try {
                                  File? selectedImage = await Get.to<File>(
                                    () => const CameraPage(),
                                  );

                                  if (selectedImage != null) {
                                    String downloadURL =
                                        await uploadImageToFirebaseStorage(
                                      selectedImage.path,
                                    );

                                    if (downloadURL.isNotEmpty) {
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.email)
                                          .update({
                                        'Avatar': downloadURL,
                                      });
                                      AvatarUrl.set(downloadURL);
                                    }
                                    setState(() {});
                                  }
                                  Utils().toastMessage("Successfully Updated ");
                                } catch (error) {
                                  Utils().toastMessage(
                                      "Successfully Updated $error ");
                                } finally {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.photo_camera,
                                    color: Colors.blue,
                                    size: 32,
                                  ),
                                  Text(
                                    'Camera',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.photo,
                                      color: Colors.blue, size: 32),
                                  Text(
                                    'Gallery',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final imagePicker = ImagePicker();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      );
      final selectedImage = await imagePicker.pickImage(source: source);
      if (selectedImage != null) {
        String downloadURL = await uploadImageToFirebaseStorage(
          selectedImage.path,
        );
        _fetchSellerDetails();
        ////////sdcscs
        if (downloadURL.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.email)
              .update({
            'Avatar': downloadURL,
          });
          AvatarUrl.set(downloadURL);
        }
        setState(() {});
      }
    } catch (error) {
      Utils().toastMessage("Error occured");
    } finally {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  Future<String> uploadImageToFirebaseStorage(String imagePath) async {
    Reference storageReference = FirebaseStorage.instance.ref('avatar');
    int a = DateTime.now().millisecondsSinceEpoch;
    UploadTask uploadTask =
        storageReference.child('$a').putFile(File(imagePath));

    try {
      await uploadTask.whenComplete(() {});
    } catch (error) {
      Utils().toastMessage("Error occured");
    }
    String downloadURL = await storageReference.child('$a').getDownloadURL();
    return downloadURL;
  }
}
