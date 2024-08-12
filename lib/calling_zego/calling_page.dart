import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cehpoint_marketplace_seller/utility.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// ignore: must_be_immutable
class Callpage extends StatelessWidget {
  String callID = "";
  String callName = "";
  String userID = "";
  String userName = "";

  Callpage(
      {super.key,
      required this.callID,
      required this.userID,
      required this.userName,
      required this.callName}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('Call History')
        .add({
      'Name': callName,
      'callID': callID,
      'Direction': "Outgoing",
      'Date-Time': DateTime.now(),
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(callID)
        .collection('Call History')
        .add({
          'Name': userName, 
          'callID': userID, 
          'Direction': "Incoming",
          'Date-Time': DateTime.now(),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
          appID: Utils.getappId(),
          appSign: Utils.getappSign(),
          callID: callID,
          userID: userID,
          userName: userName,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
            ..onOnlySelfInRoom = (context) {
              Navigator.of(context).pop();
            }),
    );
  }
}
