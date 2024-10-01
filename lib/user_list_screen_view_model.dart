import 'package:flutter/cupertino.dart';
import 'package:girman_user_data/user.dart';
import 'package:url_launcher/url_launcher.dart';

class UserListViewModel extends ChangeNotifier {
  List<User> usersList = [];

  UserListViewModel() {
    setData();
  }

  Future setData() async {
    notifyListeners();
  }


  void launchURL(String url) async {
    if (await canLaunchUrl(Uri(path: url))) {
      await launchUrl(Uri(path: url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'contact@girmantech.com',
      query: Uri.encodeFull('subject=Contact Us'), // Optional
    );
    await launch(emailLaunchUri.toString());
  }
}
