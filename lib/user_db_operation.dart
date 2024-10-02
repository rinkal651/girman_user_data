import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:girman_user_data/user.dart';

class UserDbOperation {
  static const DB_NAME = "user_list";

  static const FIRST_NAME = "first_name";
  static const LAST_NAME = "last_name";
  static const CITY = "city";
  static const CONTACT_NUMBER = "contact_number";
  void addUser(
      {required String city, required String contact_number, required String first_name, required String last_name}) {
    FirebaseFirestore.instance.collection(DB_NAME).add({
      UserDbOperation.FIRST_NAME: first_name,
      UserDbOperation.LAST_NAME: last_name,
      UserDbOperation.CITY: city,
      UserDbOperation.CONTACT_NUMBER: contact_number,
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<User>> getUser() async {
    List<User> userList = [];
    QuerySnapshot user = await FirebaseFirestore.instance.collection(DB_NAME).get();
    final allData = user.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    for(int counter =0; counter<allData.length; counter++) {
      userList.add(User.fromJson(allData[counter]));
    }
    return userList;
  }
}
