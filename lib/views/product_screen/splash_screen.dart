// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Home_Page.dart';
import 'package:cehpoint_marketplace_seller/auth/login_page.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/product_home_screen.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// splashServices() {
//   Timer(Duration(seconds: 2), () {
//     Get.offAll(() => LoginPage());
//   });
// }

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? email;

  @override
  void initState() {
    super.initState();
    // Listen for changes in authentication state
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        handleLoggedInUser(user);
      } else {
        navigateToLoginPage();
      }
    });
  }

  void handleLoggedInUser(User user) async {
    email = user.email;
    try {
      // Check if user data is available from Firebase Auth
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(email!)
          .get();
      final userData = userDoc.data();

      if (userData != null) {
        intializeCalling(
          userId: email!,
          userName: userData['Display Name'],
        );

        if (userData['Property'] == true) {
          Get.offAll(() => HomeScreenProperty(email: email!));
        } else if (userData['Product'] == true) {
          Get.offAll(() => ProductHomeScreen(email: email!));
        } else if (userData['Service'] == true) {
          Get.offAll(() => Home());
        }
      } else {
        Utils().toastMessage("Error retrieving user data");
        navigateToLoginPage();
      }
    } catch (e) {
      ZegoUIKitPrebuiltCallInvitationService().uninit();
      auth.signOut();
      Utils().toastMessage("An error occurred: ${e.toString()}");
      navigateToLoginPage();
    }
  }

  void navigateToLoginPage() {
    Timer(Duration(seconds: 2), () => Get.offAll(() => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      body: Center(child: Image.asset("assets/images/logo.png")),
    );
  }

  void intializeCalling({
    required String userId,
    required String userName,
  }) {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 821820474 /*input your AppID*/,
      appSign:
          '6ac4baebe9f8c71ee3af282c3d1bf139b36100eb5b7eb1f8d8f9d1c5a3320746',
      /*input your AppSign*/
      userID: userId,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }
}
