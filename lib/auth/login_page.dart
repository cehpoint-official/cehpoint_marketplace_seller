// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cehpoint_marketplace_seller/common/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/Service%20Section/Home_Page.dart';
import 'package:cehpoint_marketplace_seller/auth/forget_pass.dart';
import 'package:cehpoint_marketplace_seller/auth/sign_up.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/product_home_screen.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.toString().toLowerCase(),
        password: passController.text.toString(),
      );

      Utils().toastMessage(
          "User logged in successfully using ${userCredential.user!.email}");

      // Navigate to the home screen using GetX navigation
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(emailController.text.toString().toLowerCase())
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;

        if (userData['Property'] == true) {
          intializeCalling(
              userId: emailController.text.toString().toLowerCase(),
              userName: userData['Display Name']);
          Get.offAll(() => HomeScreenProperty(
                email: emailController.text.toString().toLowerCase(),
              ));
        } else if (userData['Product'] == true) {
          Get.offAll(() => ProductHomeScreen(
                email: emailController.text.toString().toLowerCase(),
              ));
        } else if (userData['Service'] == true) {
          Get.offAll(() => Home());
        }
      } else {
        Utils().toastMessage("User data not found");
      }
    } on FirebaseAuthException {
      Utils().toastMessage("Invalid email or password");
    } catch (e) {
      Utils().toastMessage("An unexpected error occurred: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        color: ColorConstants.blue700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to\nCehpoint\nMarketplace",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 10,
                          width: 40,
                          decoration: BoxDecoration(
                            color: logoColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 310,
                    child: SizedBox(
                      height: 512,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: appColor),
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: appColor),
                              ),
                              TextFormField(
                                obscureText: !isPasswordVisible,
                                controller: passController,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Your Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => ForgetPassword());
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: appColor),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10),
                              // Row(
                              //   children: [
                              //     SizedBox(
                              //       width: 148,
                              //       child: Divider(thickness: 2),
                              //     ),
                              //     Text(" or ",
                              //         style: TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.w700,
                              //         )),
                              //     SizedBox(
                              //       width: 148,
                              //       child: Divider(thickness: 2),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Container(
                              //       height: 41,
                              //       width: 41,
                              //       decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.grey),
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       child: Image.asset("assets/images/fb.png"),
                              //     ),
                              //     SizedBox(width: 15),
                              //     Container(
                              //       height: 41,
                              //       width: 41,
                              //       decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.grey),
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       child: Image.asset(
                              //           "assets/images/google-icon.png"),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: 15),
                              if (isLoading)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Loading'),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Utils.customLoadingSpinner(),
                                    ),
                                  ],
                                )
                              else
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      login();
                                    }
                                  },
                                  child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: appColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 0, color: Colors.grey),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: whiteColor),
                                        ),
                                      )),
                                ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New Here?",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => SignUpPage());
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF97C1FF)),
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }

  void intializeCalling({
    required String userId,
    required String userName,
  }) {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
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
