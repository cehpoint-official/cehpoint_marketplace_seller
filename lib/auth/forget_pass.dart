// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: Text(
          "Sell on Cehpoint",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: whiteColor),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.help_outline_outlined,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "To Change Your Password, \n Please Enter Your Email",
                style: TextStyle(fontSize: 21),
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                        hintText: "Enter Your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        // label: Text("Enter Your Email"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required *';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RoundedButton(
                  title: "Forget Password",
                  buttonColor: greenColor,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                    sendResettingPasswordLink();
                  }),
            )
          ],
        ),
      ),
    );
  }

  void sendResettingPasswordLink() {
    auth
        .sendPasswordResetEmail(email: emailController.text.toString())
        .then((value) {
      Utils().toastMessage(
          "We have Sent you an Email containing password resetting Link, please check your Email");
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }
}
