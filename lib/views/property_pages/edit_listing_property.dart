import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';

class PropertyEditPage extends StatefulWidget {
  final String email;
  const PropertyEditPage({
    super.key,
    required this.email,
  });

  @override
  State<PropertyEditPage> createState() => _PropertyEditPageState();
}

class _PropertyEditPageState extends State<PropertyEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "Edit Property",
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(builder: (BuildContext builderContext) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, true);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: whiteColor,
            ),
          );
        }),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel_outlined),
            SizedBox(
              height: 10,
            ),
            Text(
              "Property Edit Page is Under Developement Phase",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color.fromARGB(255, 110, 110, 110)),
            ),
          ],
        ),
      ),
    );
  }
}
