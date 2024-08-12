import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cehpoint_marketplace_seller/common/rounded_button.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/SELECTION.dart';

class ServicesOfferedProperty extends StatefulWidget {
  final List<String> initialSelectedServices;
  final Function(List<String>) onSelectionChanged;

  const ServicesOfferedProperty({
    Key? key,
    required this.initialSelectedServices,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<ServicesOfferedProperty> createState() =>
      _ServicesOfferedPropertyState();
}

class _ServicesOfferedPropertyState extends State<ServicesOfferedProperty> {
  late List<String> servicesOffered;
  List<String> serviceList = SELECTION.fetchServicesList();

  @override
  void initState() {
    super.initState();
    servicesOffered = List.from(widget.initialSelectedServices);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Services",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () {
                  Get.back(result: servicesOffered);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: serviceList.length,
            itemBuilder: (context, index) {
              final serviceName = serviceList[index];
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Row(
                    children: [
                      Checkbox(
                        value: servicesOffered.contains(serviceName),
                        onChanged: (value) {
                          if (value!) {
                            setState(() {
                              servicesOffered.add(serviceName);
                            });
                          } else {
                            setState(() {
                              servicesOffered.remove(serviceName);
                            });
                          }
                          // Notify the parent about the updated selection
                          widget.onSelectionChanged(servicesOffered);
                        },
                      ),
                      Expanded(
                        child: Text(
                          serviceName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
        RoundedButton(
            title: "Add More Service",
            radius: 0,
            onTap: () {
              addMoreServicesPopup();
              widget.onSelectionChanged(servicesOffered);
            }),
      ],
    );
  }

  void addMoreServicesPopup() {
    String val = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter Title',
                  style: TextStyle(fontSize: 17),
                ),
                IconButton(
                    onPressed: () {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded))
              ],
            ),
            content: Wrap(
              children: [
                TextField(
                  onChanged: (value) {
                    val = value;
                  },
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color.fromRGBO(33, 150, 243, 1),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      SELECTION.servicesList.add(val);
                      serviceList.add(val);
                      servicesOffered.add(val);
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: const Text(
                      "Create",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
