import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:girman_user_data/girman_appbar.dart';
import 'package:girman_user_data/user.dart';
import 'package:girman_user_data/user_data_list_listview.dart';
import 'package:provider/provider.dart';

import 'user_list_screen_view_model.dart';

enum AppBarMenu { SEARCH, WEBSITE, LINKEDIN, CONTACT }

class UserListScreen extends StatefulWidget {
  UserListScreen._(Key? key) : super(key: key);

  static Widget createInstance({Key? key}) {
    return ChangeNotifierProvider(
      create: (context) => UserListViewModel(),
      child: UserListScreen._(key),
    );
  }

  @override
  _UserListScreen createState() => _UserListScreen();
}

class _UserListScreen extends State<UserListScreen>
    with WidgetsBindingObserver {
  late double listHeight ;
      bool isLoading = false;
  UserListViewModel get _viewModel {
    return Provider.of<UserListViewModel>(context, listen: false);
  }

  bool isTextfieldActivated = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    listHeight = MediaQuery.of(context).size.height - 205;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    listHeight -=keyboardHeight;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: GirmanAppbar(context, displayMenu: true),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 1), // First RGBA color (Red with 70% opacity)
                  Color.fromRGBO(177, 203, 255, 1), // Second RGBA color (Blue with 70% opacity)
                ],
                begin: Alignment.topCenter, // Start position of the gradient
                end: Alignment.bottomCenter, // End position of the gradient
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isTextfieldActivated ? Container() : Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 90),
                    child: SvgPicture.asset(
                      'assets/images/home_screen_logo.svg',
                      height: 60,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (val){
                      _viewModel.filterData(val);
                    },
                    onTap: (){
                      setState(() {
                        isTextfieldActivated = true;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 215, 215, 235), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 215, 215, 235), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                  ),
                ),
                isTextfieldActivated ? Consumer<UserListViewModel>(
                    builder: (context, viewModel, child) {
                      Widget consumerChild;
                  final usersCount = viewModel.filteredUsersList.length;
                  if (usersCount > 0) {
                    consumerChild= UserDataListListView(
                        items: _viewModel.filteredUsersList,
                        onItemPressed: (user) {
                          openUserDetails(user);
                        });
                  } else {
                    consumerChild= Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset('assets/images/empty_list.png'),
                            Text("No results found.", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.78, color: Color.fromARGB(255, 153, 153, 153))),
                          ],
                        ),
                        physics: const AlwaysScrollableScrollPhysics(),
                      ),
                    );
                  }
                  return AnimatedContainer(
                          duration: Duration(milliseconds: 30),
                          width: MediaQuery.of(context).size.width,
                      height: listHeight,
                      child: consumerChild);
                }) : Container()
              ],
            ),
          ),
        ));
  }

  openUserDetails(User user) {
    showDialog(context: context, builder: (BuildContext context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 16,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Fetch Details", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22.22, color: Color.fromARGB(255, 9, 9, 11))),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: SvgPicture.asset('assets/images/close_icon.svg', height: 15, width: 15,))
                ],
              ),
              SizedBox(height: 5,),
              Text("Here are the details of following employee.", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12.96, color: Color.fromARGB(255, 113, 113, 122))),
              SizedBox(height: 5,),

              Text("Name: "+user.first_name+" "+user.last_name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.96, color: Color.fromARGB(255, 9, 9, 11))),
              Text("Location: "+user.city, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.96, color: Color.fromARGB(255, 9, 9, 11))),
              Text("Contact Number: "+user.contact_number, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.96, color: Color.fromARGB(255, 9, 9, 11))),
              SizedBox(height: 3,),
              Text("Profile Image: ", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.96, color: Color.fromARGB(255, 9, 9, 11))),
              SizedBox(height: 3,),
              Image.asset('assets/images/user_img.png', height: 192, width: 192),
              SizedBox(height: 40,)
            ],
          ),
        ),
      );
    });
  }
}
