// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ServiceTab extends StatefulWidget {
  const ServiceTab({Key? key}) : super(key: key);

  @override
  State<ServiceTab> createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  var sort = [
    {'name': 'Makeup', 'image': 'assets/images/makeup.png', 'selected': false},
    {'name': 'Hair', 'image': 'assets/images/hair.png', 'selected': false},
    {
      'name': 'Nail care',
      'image': 'assets/images/nails.png',
      'selected': false
    },
    {'name': 'Waxing', 'image': 'assets/images/waxing.png', 'selected': false},
    {
      'name': 'Special Packages',
      'image': 'assets/images/special.png',
      'selected': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    // var h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Wrap(
        children: sort.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> value = entry.value;
          return Container(
            height: 60,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              // color: value['selected'] ? Colors.amber : Colors.white,
              border: Border.all(
                color: value['selected'] ? Colors.white : Colors.amber,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  sort[index]['selected'] = !(sort[index]['selected'] as bool);
                });
              },
              child: Text(value['name'].toString()),
            ),
          );
        }).toList(),
      ),
    );
  }
}
