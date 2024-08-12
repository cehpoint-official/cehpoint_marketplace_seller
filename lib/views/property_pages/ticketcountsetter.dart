import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Ticketcountsetter {
  static late Future<int> countDataFuture;
  static late Future<int> countDataFutureRes;
  static late Future<int> countDataFuturePen;

  static Future<void> countDataA(String status, String email) async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> alldocuments = await FirebaseFirestore
        .instance
        .collection('Property_Tickets')
        .doc(email)
        .collection(email)
        .get();
    Map<String, dynamic> documentsMap = {};
    for (QueryDocumentSnapshot documentSnapshot in alldocuments.docs) {
      documentsMap[documentSnapshot.id] = documentSnapshot.data();
    }
    documentsMap.forEach((documentId, itemData) {
      if (itemData['title'] != null) {
        if (status == "") {
          data.add(itemData);
        } else if (status == "pending") {
          if (itemData['Reply'].toString() == "") {
            data.add(itemData);
          }
        } else if (status == "resolved") {
          if (itemData['Reply'].toString() != "") {
            data.add(itemData);
          }
        }
      }
    });

    countDataFuture = Future.value(data.length);
  }

  static Future<void> countDataR(String status, String email) async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> alldocuments = await FirebaseFirestore
        .instance
        .collection('Property_Tickets')
        .doc(email)
        .collection(email)
        .get();
    Map<String, dynamic> documentsMap = {};
    for (QueryDocumentSnapshot documentSnapshot in alldocuments.docs) {
      documentsMap[documentSnapshot.id] = documentSnapshot.data();
    }
    documentsMap.forEach((documentId, itemData) {
      if (itemData['title'] != null) {
        if (status == "") {
          data.add(itemData);
        } else if (status == "pending") {
          if (itemData['Reply'].toString() == "") {
            data.add(itemData);
          }
        } else if (status == "resolved") {
          if (itemData['Reply'].toString() != "") {
            data.add(itemData);
          }
        }
      }
    });
    countDataFutureRes = Future.value(data.length);
    // countDataFutureRes = data.length as Future<int>;
  }

  static Future<void> countDataP(String status, String email) async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot<Map<String, dynamic>> alldocuments = await FirebaseFirestore
        .instance
        .collection('Property_Tickets')
        .doc(email)
        .collection(email)
        .get();
    Map<String, dynamic> documentsMap = {};
    for (QueryDocumentSnapshot documentSnapshot in alldocuments.docs) {
      documentsMap[documentSnapshot.id] = documentSnapshot.data();
    }
    documentsMap.forEach((documentId, itemData) {
      if (itemData['title'] != null) {
        if (status == "") {
          data.add(itemData);
        } else if (status == "pending") {
          if (itemData['Reply'].toString() == "") {
            data.add(itemData);
          }
        } else if (status == "resolved") {
          if (itemData['Reply'].toString() != "") {
            data.add(itemData);
          }
        }
      }
    });
    // Completer<int> completer = Completer<int>();
    // completer.complete(data.length);
    // countDataFuturePen = completer.future;
    countDataFuturePen = Future.value(data.length);
    // countDataFuturePen = data.length as Future<int>;
  }

  static Future<int> fetchAll() {
    return countDataFuture;
  }

  static Future<int> fetchR() {
    return countDataFutureRes;
  }

  static Future<int> fetchP() {
    return countDataFuturePen;
  }
}
