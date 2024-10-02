import 'package:flutter/cupertino.dart';
import 'package:girman_user_data/user.dart';
import 'package:girman_user_data/user_db_operation.dart';
import 'package:url_launcher/url_launcher.dart';

class UserListViewModel extends ChangeNotifier {
  List<User> usersList = [];
  List<User> filteredUsersList = [];
  var userDbOp = UserDbOperation();

  UserListViewModel() {
    setData();
  }

  Future setData() async {
    usersList.addAll(await userDbOp.getUser());
    filteredUsersList = usersList;
    notifyListeners();
  }

  filterData(String query) {
    if (query.isEmpty) {
      filteredUsersList = usersList; // Return all users if query is empty
    } else {
      filteredUsersList = usersList
          .where((e) => e.first_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  static void launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@girmantech.com',
      queryParameters: {'subject': 'Contact Us'}, // Optional
    );
    await launchUrl(emailLaunchUri);
  }
}
