// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Home_Page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

splashServices() {
  Timer(const Duration(seconds: 2), () {
    Get.offAll(() => const Home());
  });
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("helo world"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.to(() => const Home());
          },
          child: const Text("Home"),
        ),
      ),
    );
  }
}
