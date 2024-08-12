import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';

class AdvertisingProperty extends StatefulWidget {
  final String email;
  const AdvertisingProperty({
    super.key,
    required this.email,
  });

  @override
  State<AdvertisingProperty> createState() => _AdvertisingPropertyState();
}

class _AdvertisingPropertyState extends State<AdvertisingProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "Advertising",
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel_outlined),
            SizedBox(
              height: 10,
            ),
            Text(
              "Advertising Section is Under Developement Phase",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color.fromARGB(255, 110, 110, 110)),
            ),
          ],
        ),
      ),
    );
  }
}
