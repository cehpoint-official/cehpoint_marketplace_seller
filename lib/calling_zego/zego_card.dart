import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoCard extends StatelessWidget {
  final String displayName;
  final String name;
  final String id;
  final String email;
  final String username;
  const ZegoCard(
      {super.key,
      required this.displayName,
      required this.name,
      required this.email,
      required this.username,
      required this.id});

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        margin: const EdgeInsets.only(top: 12, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  displayName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(
                        255, 0, 0, 0), // Change this to your desired color
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              ZegoSendCallInvitationButton(
                onPressed: (code, message, p2) {
                  DateTime nowTime = DateTime.now();
                  FirebaseFirestore.instance
                    .collection('users')
                    .doc(email)
                    .collection('Call History')
                    .doc()
                    .set({
                      'Name' : name,
                      'CallID' : id,
                      'Direction' : "Outgoing",
                      'Date-Time' : nowTime,
                    });
                  FirebaseFirestore.instance
                    .collection('Agents')
                    .doc(id)
                    .collection('Call History')
                    .doc()
                    .set({
                      'Name' : username,
                      'CallID' : email,
                      'Direction' : "Incoming",
                      'Date-Time' : nowTime,
                    });
                },
                notificationTitle: username,
                notificationMessage: "Seller is calling you",
                buttonSize: const Size(50, 50),
                icon: ButtonIcon(icon: const Icon(Icons.call)),
                iconSize: const Size(40, 40),
                isVideoCall: false,
                resourceID: "zego_sokoni",
                invitees: [
                  ZegoUIKitUser(
                    id: id,
                    name: name,
                  )
                ],
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Container();
    }
  }
}
