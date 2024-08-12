// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:cehpoint_marketplace_seller/auth/login_page.dart';
import 'package:cehpoint_marketplace_seller/common/bold_text.dart';
import 'package:cehpoint_marketplace_seller/common/plain_text.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/product_screen/product_home_screen.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:pinput/pinput.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

var logger = Logger();

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  var pnCode = "";
  var emCode = "";
  int currentTab = 0;
  bool filepicked = false;
  String filename = "";
  String licenceDownloadURL = "";
  String veriId = "";
  bool isChecked = F;
  String selectedSeller = "Product";
  String selectedFeature = "Product";
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController displaynameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController tinController = TextEditingController();
  TextEditingController vrnController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController storeDescController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController bankHolderNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController confirmAccountNoController = TextEditingController();
  TextEditingController bankSwiftCodeController = TextEditingController();

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: greyColor),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _fetchUserData() async {
    User? user = auth.currentUser;

    String uid = user!.uid;
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(uid).get();

    setState(() {
      nameController.text = userDoc.get('name') ?? 'No Name';
      emailController.text = user.email?.toLowerCase() ?? 'No Email';
      phoneController.text = userDoc.get('phone') ?? 'No Phone';
    });
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF08215E),
        title: Row(
          children: [
            PlainText(
              name: "Sell On Cehpoint",
              fontsize: 20,
              fontWeight: FontWeight.w400,
              color: whiteColor,
            ),
          ],
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
            onTap: () {
              Get.to(() => ProductHomeScreen(
                    email: emailController.text.toLowerCase(),
                  ));
            },
            child: Icon(
              Icons.help_outline_outlined,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        // color: Colors.amber,
        height: 650,
        width: w,
        child: Column(
          children: [
            TabBar(
              onTap: (value) {
                navigateToTab(currentTab);
              },
              controller: tabController,
              tabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 18),
                      Expanded(
                        child: Text(
                          "Email ID,\nTIN & VAN",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 22),
                      Expanded(
                        child: Text(
                          "Password Creation",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 20),
                      Expanded(
                        child: Text(
                          "Onboarding Dashboard",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              dividerColor: Colors.transparent,
              labelColor: Color(0xFF08215E),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.amber),
                insets: EdgeInsets.symmetric(horizontal: -16.0),
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    //tab 1
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Form(
                            key: formKey1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      label: Text("Enter Mobile Number"),
                                      hintText: "1234567890",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          sendPhoneOTP();
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Container(
                                              height: 34,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF0F7BDF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Text(
                                                "Send OTP",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            )),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Phone Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Enter OTP sent to your Mobile Number",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 57,
                                        width: 220,
                                        child: Pinput(
                                          defaultPinTheme: defaultPinTheme,
                                          showCursor: true,
                                          length: 6,
                                          onChanged: (value) {
                                            pnCode = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: () async {
                                          final credDetails =
                                              PhoneAuthProvider.credential(
                                            verificationId: veriId,
                                            smsCode: pnCode,
                                          );
                                          try {
                                            await auth.signInWithCredential(
                                                credDetails);
                                            Utils().toastMessage(
                                                "Phone Verified Succesfully");
                                          } catch (e) {
                                            Utils().toastMessage(e.toString());
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFFF7931D)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "Verify",
                                              style: TextStyle(
                                                  color: Color(0xFFF7931D),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.email_outlined),
                                      hintText: "xyz@gmail.com",
                                      // focusedBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      label: Text("Enter Email ID"),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          if (emailController.text.isEmpty) {
                                            Fluttertoast.showToast(
                                              msg: 'Enter valid Email',
                                              backgroundColor: Colors.grey,
                                            );
                                          } else {
                                            sendingEmailVerification();
                                            Fluttertoast.showToast(
                                              msg: 'Submitted !!',
                                              backgroundColor: Colors.grey,
                                            );
                                          }
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Container(
                                              height: 34,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF0F7BDF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            )),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "What do you want to sell?",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      buildContainer("Product"),
                                      SizedBox(width: 20),
                                      buildContainer("Service"),
                                      SizedBox(width: 20),
                                      buildContainer("Property"),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: tinController,
                                    decoration: InputDecoration(
                                        label: Text("Enter TIN"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter TIN Number';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "TIN is required to sell product on Cehpoint.",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: greyColor),
                                      ),
                                      SizedBox(width: 3),
                                      InkWell(
                                        onTap: () {
                                          Utils().toastMessage(
                                              "TIN Number Verified Successfully");
                                        },
                                        child: Container(
                                          height: 34,
                                          width: 72,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xFFF7931D)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "Verify",
                                              style: TextStyle(
                                                  color: Color(0xFFF7931D),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: vrnController,
                                    decoration: InputDecoration(
                                        label: Text("VRN Number(optional)"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(height: 20),
                                  if (selectedFeature == "Property")
                                    Stack(
                                      children: [
                                        if (!filepicked)
                                          SizedBox(
                                            width: w * 0.6,
                                            child: RoundedButton(
                                              title: "Upload Business Licence",
                                              fontsize: 14,
                                              textColor: whiteColor,
                                              buttonColor: Color.fromARGB(
                                                  255, 8, 114, 228),
                                              onTap: () {
                                                pickDocument();
                                              },
                                            ),
                                          ),
                                        if (filepicked)
                                          SizedBox(
                                            width: w,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                        Icons.document_scanner),
                                                    Text(
                                                      filename,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        filepicked = false;
                                                      });
                                                    },
                                                    icon: Icon(
                                                        Icons.close_rounded)),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isChecked = !isChecked;
                                          });
                                        },
                                        child: Icon(
                                          isChecked
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                          size: 30.0,
                                          color: isChecked
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                            text: 'I agree to Cehpoint’s ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: 'Terms of Use',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Handle the tap on "Terms of Use"
                                                debugPrint(
                                                    'Terms of Use tapped!');
                                              },
                                          ),
                                          TextSpan(
                                            text: ' & ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Handle the tap on "Privacy Policy"
                                                debugPrint(
                                                    'Privacy Policy tapped!');
                                              },
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: RoundedButton(
                              title: "Register & Continue  ",
                              textColor: blackColor,
                              // textColor: whiteColor,
                              buttonColor: Color(0xFF08E446),
                              iconsDataRight: Icons.arrow_forward,
                              onTap: () {
                                if (selectedFeature == "Property" &&
                                    formKey1.currentState!.validate() &&
                                    isChecked) {
                                  if (!filepicked) {
                                    Utils().toastMessage(
                                        'Please upload Business Licence');
                                  } else {
                                    currentTab = currentTab + 1;
                                    navigateToTab(currentTab);
                                  }
                                } else if (selectedFeature != "Property" &&
                                    formKey1.currentState!.validate() &&
                                    isChecked) {
                                  currentTab = currentTab + 1;
                                  navigateToTab(currentTab);
                                }

                                if (!isChecked) {
                                  Utils().toastMessage(
                                      'Please agree to conditions');
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 1250,
                            width: w,
                            decoration: BoxDecoration(
                                // color: appColor,
                                ),
                            child: Column(
                              children: [
                                // Image.asset("assets/images/sellPoster.png"),
                                // SizedBox(height: 20),
                                BoldText(
                                  name: "WHY SELL ON CEHPOINT?",
                                  fontsize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(height: 20),
                                Expanded(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          height: 202,
                                          width: w,
                                          color: whiteColor,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 84,
                                                width: 84,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: sellColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                    sellItemIcon[index],
                                                    color: sellColor,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              BoldText(
                                                  name: sellItemList[index],
                                                  fontsize: 16),
                                              SizedBox(height: 10),
                                              PlainText(
                                                name:
                                                    "Lorem ipsum dolor sit amet consectetur adipisicing Facere expedita quibusdam assumenda explicabo .",
                                                fontsize: 14,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Column(
                          children: [
                            Form(
                              key: formKey2,
                              child: Column(
                                children: [
                                  Text(
                                    "We have sent a verification link on your email. Verify your email Id.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: passController,
                                    obscureText: !isPasswordVisible,
                                    obscuringCharacter: "*",
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      label: Text("Create Password"),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: confirmPassController,
                                    obscureText: !isConfirmPasswordVisible,
                                    obscuringCharacter: "*",
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isConfirmPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isConfirmPasswordVisible =
                                                !isConfirmPasswordVisible;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      label: Text("Confirm Password"),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Password again';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        label: Text("Full Name")),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Your Full Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (selectedFeature != "Product")
                                    TextFormField(
                                      controller: displaynameController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          label: Text("Display Name")),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Display Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  if (selectedFeature == "Product")
                                    TextFormField(
                                      controller: storeNameController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          label: Text("Store Name")),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Your Store Name ';
                                        }
                                        return null;
                                      },
                                    ),
                                  if (selectedFeature == "Product")
                                    SizedBox(
                                      height: 10,
                                    ),
                                  if (selectedFeature == "Product")
                                    TextFormField(
                                      controller: storeDescController,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 15, right: 10, top: 15),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          label: Text("Store Description")),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Store Description';
                                        }
                                        return null;
                                      },
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RoundedButton(
                              title: "Continue",
                              iconsDataRight: Icons.arrow_forward,
                              iconColor: Colors.white,
                              onTap: () {
                                if (formKey2.currentState!.validate()) {
                                  linkEmailToPhone(
                                      emailController.text
                                          .toString()
                                          .toLowerCase(),
                                      passController.text.toString());
                                  currentTab = currentTab + 1;
                                  navigateToTab(currentTab);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello ${nameController.text}",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Mobile & Email verification",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.phone_android_outlined),
                                      SizedBox(width: 10),
                                      Text(
                                        "+255 ${phoneController.text}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: greenColor,
                                      ),
                                      Text(
                                        "Verified",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: greenColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.email_outlined),
                                      SizedBox(width: 10),
                                      Text(
                                        emailController.text.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: greenColor,
                                      ),
                                      Text(
                                        "Verified",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: greenColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.percent),
                                      SizedBox(width: 10),
                                      Text(
                                        "VRN Verify",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: greenColor,
                                      ),
                                      Text(
                                        "Verified",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: greenColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.percent),
                                      SizedBox(width: 10),
                                      Text(
                                        "TIN Verify",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: greenColor,
                                      ),
                                      Text(
                                        "Verified",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: greenColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (selectedFeature == "Property")
                                SizedBox(height: 10),
                              if (selectedFeature == "Property")
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.mail),
                                        SizedBox(width: 10),
                                        Text(
                                          "Company License",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: greenColor,
                                        ),
                                        Text(
                                          "Verified",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: greenColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (selectedFeature == "Property")
                                SizedBox(height: 40),
                              if (selectedFeature == "Property")
                                TextFormField(
                                  controller: contactNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Contact Number")),
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Contact Number';
                                    }
                                    return null;
                                  },
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 15),
                              if (selectedFeature == "Product")
                                Text(
                                  "Pick up Details",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 10),
                              if (selectedFeature == "Product")
                                TextFormField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Pick Up Address")),
                                  maxLines: 2,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Your Pick Up Address';
                                    }
                                    return null;
                                  },
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 10),
                              if (selectedFeature == "Product")
                                TextFormField(
                                  controller: pinCodeController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Pick Up PIN Code")),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Your Pick Up PIN Code"';
                                    }
                                    return null;
                                  },
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 15),
                              if (selectedFeature == "Product")
                                Text(
                                  "Add Bank Account Details",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 10),
                              if (selectedFeature == "Product")
                                TextFormField(
                                  controller: bankHolderNameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Name of Account Holder")),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Bank Holder Name';
                                    }
                                    return null;
                                  },
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 10),
                              if (selectedFeature == "Product")
                                TextFormField(
                                  controller: accountNoController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Account Number")),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Your Account Number';
                                    }
                                    return null;
                                  },
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 10),
                              if (selectedFeature == "Product")
                                TextFormField(
                                  controller: confirmAccountNoController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Confirm Account Number")),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Confirm Your Account Number';
                                    }
                                    return null;
                                  },
                                ),
                              if (selectedFeature == "Product")
                                SizedBox(height: 10),
                              if (selectedFeature == "Product")
                                TextFormField(
                                  controller: bankSwiftCodeController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      label: Text("Bank Swift Code")),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Your Bank Swift Code';
                                    }
                                    return null;
                                  },
                                ),
                              SizedBox(height: 10),
                              RoundedButton(
                                  title: "Save & Continue",
                                  onTap: () {
                                    if (formKey3.currentState!.validate()) {
                                      if (selectedFeature == "Product") {
                                        addDataToFirestoreProduct();
                                      } else if (selectedFeature ==
                                          "Property") {
                                        addDataToFirestoreProperty();
                                      } else if (selectedFeature == "Service") {
                                        Utils().toastMessage(
                                            "Service Feature not yet available");
                                      }
                                      Get.to(() => LoginPage());
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String typeOfSeller) {
    bool isSelected = selectedSeller == typeOfSeller;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFeature = typeOfSeller;
          selectedSeller = typeOfSeller;
          logger.d(typeOfSeller);
        });
      },
      child: Container(
        height: 42,
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: isSelected ? Colors.blue : Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            typeOfSeller,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Future<void> sendPhoneOTP() async {
    try {
      String phoneNumber = '+91${phoneController.text.trim()}';
      if (phoneNumber.isNotEmpty) {
        await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (e) {
            Utils().toastMessage(e.toString());
          },
          codeSent: (String verificationId, int? token) {
            setState(() {
              veriId = verificationId;
            });
          },
          codeAutoRetrievalTimeout: (e) {
            // Utils().toastMessage(e.toString());
          },
        );
      } else {
        Utils().toastMessage('Please enter a valid phone number');
      }
    } catch (e) {
      debugPrint("Error sending OTP: $e");
      Utils().toastMessage(e.toString());
    }
  }

  void emailSignUp() {
    try {
      auth.createUserWithEmailAndPassword(
        email: emailController.text.toString().toLowerCase(),
        password: passController.text.toString(),
      );
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  Future<void> linkEmailToPhone(String email, String password) async {
    try {
      AuthCredential emailCredential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      debugPrint(email);

      // Get the currently signed-in user
      User? currentUser = auth.currentUser;

      if (currentUser != null) {
        // Link the email credential to the user account
        await currentUser.linkWithCredential(emailCredential);
        navigateToTab(1);
        // Utils().toastMessage("Successfully Linked Account");
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
      debugPrint("Error: $e");
    }
  }

  void sendingEmailVerification() async {
    try {
      String email = emailController.text.trim().toLowerCase();
      if (email.isNotEmpty) {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          await user.updateEmail(email);

          Utils().toastMessage("Verification email sent to $email");
          debugPrint("Verification email sent to $email");
        } else {
          debugPrint("User is already verified or user is null");
        }
      } else {
        debugPrint("Email address is empty");
      }
    } catch (e) {
      debugPrint("Error sending verification email: $e");
    }
  }

  void addDataToFirestoreProduct() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collection = firestore.collection('users');

    Map<String, dynamic> data = {
      'Email': emailController.text.toString().toLowerCase(),
      'Phone': phoneController.text.toString(),
      'Name': nameController.text.toString(),
      'TIN': tinController.text.toString(),
      'VRN': vrnController.text.toString(),
      'Store_Name': storeNameController.text.toString(),
      'Store_Description': storeDescController.text.toString(),
      'Address': addressController.text.toString(),
      'Pin_Code': pinCodeController.text.toString(),
      'Bank_Holder_Name': bankHolderNameController.text.toString(),
      'Account_No': accountNoController.text.toString(),
      'Bank_SwiftCode': bankSwiftCodeController.text.toString(),
      'Property':
          false, // to track whether this user has chosen Property or not
      'Product': true, // to track whether this user has chosen Product or not
      'Service': false, // to track whether this user has chosen Service or not
      'Product Active': 0,
      'Product Inactive': 0,
      'Avatar':
          "https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/avatar%2Favatar.png?alt=media&token=0ca0100a-41cf-4c56-adf4-bb2b6724e4bf",
    };
    // collection.doc(emailController.text.toString()).set(data);
    try {
      await collection
          .doc(emailController.text.toString().toLowerCase())
          .set(data);
      if (selectedSeller == "Product") {
        Get.to(
          () => ProductHomeScreen(
            email: emailController.text.toLowerCase(),
          ),
        );
      }
      if (auth.currentUser == null) {
        emailSignUp();
      }
      Utils().toastMessage("Data Successfully Added");
    } catch (e) {
      Utils().toastMessage(e.toString());
      debugPrint("Error adding document: $e");
    }
  }

  Future<void> addDataToFirestoreProperty() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collection = firestore.collection('users');

    Map<String, dynamic> data = {
      'Email': emailController.text.toString().toLowerCase(),
      'Phone No': phoneController.text.toString(),
      'Name': nameController.text.toString(),
      'Display Name': displaynameController.text.toString(),
      'Contact Number': contactNumberController.text.toString(),
      'TIN': tinController.text.toString(),
      'VRN': vrnController.text.toString(),
      'Licence URL': licenceDownloadURL,
      'Property': true, // to track whether this user has chosen Property or not
      'Product': false, // to track whether this user has chosen Product or not
      'Service': false, // to track whether this user has chosen Service or not
      'Property Active': 0,
      'Property Inactive': 0,
      'Avatar':
          "https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/avatar%2Favatar.png?alt=media&token=0ca0100a-41cf-4c56-adf4-bb2b6724e4bf",
    };

    try {
      await collection
          .doc(emailController.text.toString().toLowerCase())
          .set(data);
      if (selectedSeller == "Property") {
        Get.to(
          () => HomeScreenProperty(
            email: emailController.text.toLowerCase(),
          ),
        );
      }
      if (auth.currentUser == null) {
        emailSignUp();
      }
      Utils().toastMessage("Data Successfully Added");
    } catch (e) {
      Utils().toastMessage(e.toString());
      debugPrint("Error adding document: $e");
    }
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        filename = result.files.single.name;
        filepicked = true;
      });
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('documents/${DateTime.now().millisecondsSinceEpoch}');

      // IMPLEMENT UPLOADING OF FILE IN FIREBASESTORAGE
      UploadTask uploadTask = storageReference.putFile(file);
      licenceDownloadURL = await (await uploadTask).ref.getDownloadURL();

      if (kDebugMode) {
        print(
            'File uploaded to Firebase Storage. Download URL: $licenceDownloadURL');
      }
    } else {
      if (kDebugMode) {
        print('User canceled the file picker');
      }
    }
  }
}
