import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/common/constant.dart';
import 'package:cehpoint_marketplace_seller/common/utils.dart';
import 'package:cehpoint_marketplace_seller/views/property_pages/property_drawer.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RequestCall extends StatefulWidget {
  const RequestCall({super.key, required this.email, required this.username});
  final String email;
  final String username;

  @override
  State<RequestCall> createState() => _RequestCallState();
}

class _RequestCallState extends State<RequestCall> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController number = TextEditingController();
  String completephonenumber = "";
  String countrycode = "";
  String numberr = "";
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    name.text = widget.username;
    email.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Pdrawer(
        email: widget.email,
      ),
      backgroundColor: const Color.fromRGBO(228, 228, 228, 1),
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "Help",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 65,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Request a call from seller support.",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  Center(
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    TextField(
                      controller: name,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      style: const TextStyle(
                          color: Color.fromARGB(231, 80, 79, 79),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: email,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      style: const TextStyle(
                          color: Color.fromARGB(231, 80, 79, 79),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IntlPhoneField(
                      controller: number,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Enter Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'TZ',
                      onChanged: (phone) {
                        setState(() {
                          completephonenumber = phone.completeNumber.toString();
                          countrycode = phone.countryCode.toString();
                          numberr = phone.number;
                        });
                      },
                      onCountryChanged: (country) {
                        Utils().toastMessage(
                            "Country has been changed to ${country.name}");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: MaterialButton(
                          textColor: Colors.white,
                          onPressed: () async {
                            _formKey.currentState?.validate();

                            try {
                              String docID =
                                  '${DateTime.now().millisecondsSinceEpoch}';
                              FirebaseFirestore firestore =
                                  FirebaseFirestore.instance;
                              await firestore
                                  .collection('propertyCallRequest')
                                  .doc(docID)
                                  .set({
                                'name': name.text.toString(),
                                'emailAdress': email.text.toString(),
                                'status': 'Pending',
                                'completeNumber': completephonenumber,
                                'countryCode': countrycode,
                                'number': numberr,
                              });

                              Utils().toastMessage(
                                  "Requested a call Successfully!");
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            } catch (e) {
                              Utils().toastMessage(e.toString());
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
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
