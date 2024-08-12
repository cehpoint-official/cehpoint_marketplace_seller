import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cehpoint_marketplace_seller/auth/login_page.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/home_screen_property.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';

class Sellmore extends StatefulWidget {
  final String email;

  const Sellmore({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<Sellmore> createState() => _SellmoreState();
}

class _SellmoreState extends State<Sellmore> {
  bool product = false;
  bool property = false;
  bool sevices = false;

  Future<void> fetchData() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.email)
          .get();

      var yourproduct = documentSnapshot['Product'];
      var yourproperty = documentSnapshot['Property'];
      var yoursevices = documentSnapshot['Service'];

      setState(() {
        product = yourproduct;
        property = yourproperty;
        sevices = yoursevices;
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Pdrawer(
          email: widget.email,
        ),
        appBar: AppBar(
          backgroundColor: appColor,
          title: const Text(
            "Sell More",
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
        ),
        body: Column(
          children: [
            _buildStack(
                'Sell Your Product',
                'Create your seller account for Products',
                product,
                'assets/images/product.png'),
            _buildStack(
                'Sell Your Property',
                'Create your seller account for Property',
                property,
                'assets/images/property.png'),
            _buildStack(
                'Sell Your Service',
                'Create your seller account for Service',
                sevices,
                'assets/images/service.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildStack(
      String title, String description, bool status, String image) {
    return GestureDetector(
      onTap: () {
        if (title == 'Sell Your Property') {
          Get.to(() => HomeScreenProperty(
                email: widget.email,
              ));
        } else {
          Get.to(() => const LoginPage());
        }
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              width: 300.0,
              height: 160.0,
              margin: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: status
                          ? Colors.transparent
                          : const Color.fromARGB(209, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10.0,
              left: 20.0,
              child: Container(
                width: 150,
                height: 40,
                color: Colors.green,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (status == false)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
