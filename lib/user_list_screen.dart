import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:girman_user_data/user_data_list_listview.dart';
import 'package:provider/provider.dart';

import 'user_list_screen_view_model.dart';

enum AppbarActionMenu { SEARCH, WEBSITE, LINKEDIN, CONTACT }

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

class _UserListScreen extends State<UserListScreen> with WidgetsBindingObserver {
  bool isLoading = false;
  UserListViewModel get _viewModel {
    return Provider.of<UserListViewModel>(context, listen: false);
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.white,
          title: SvgPicture.asset('assets/images/logo.svg', height: 45,),
          actions: [
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () => _viewModel.launchURL('https://girmantech.com'),
            ),
            IconButton(
              icon: Icon(Icons.business),
              onPressed: () => _viewModel.launchURL('https://www.linkedin.com/company/girman-technologies'),
            ),
            IconButton(
              icon: Icon(Icons.email),
              onPressed: _viewModel.launchEmail,
            ),
          ],
        ),
        body: Consumer<UserListViewModel>(
          builder: (context, viewModel, child) {
            final activeInspectionsCount = viewModel.usersList.length;

            final List<Widget> children = [];


            Widget refreshChild;
            if (activeInspectionsCount > 0) {
              refreshChild = UserDataListListView(
                  items: _viewModel.usersList,
                  onItemPressed: (inspection) {
                   // openUserDetails(inspection);
                  });
            } else {
              refreshChild = SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: Image.asset('assets/images/empty_list.png'),
                ),
                physics: const AlwaysScrollableScrollPhysics(),
              );
            }
            children.add(Expanded(child: refreshChild));

            return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 1), // First RGBA color (Red with 70% opacity)
                        Color.fromRGBO(177, 203, 255, 1), // Second RGBA color (Blue with 70% opacity)
                      ],
                      begin: Alignment.topCenter, // Start position of the gradient
                      end: Alignment.bottomCenter, // End position of the gradient
                    ),
                  ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            );
          },
        ));
  }
}


Widget menuButton() {
  return PopupMenuButton<AppbarActionMenu>(
    child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(4.0),
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black, width: 1));
                ,
                child: InkWell(
                  onTapDown: onTapDown,
                  onTap: onClick,
                  child: child ??
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        alignment: Alignment.center,
                        child: children(context),
                      ),
                ),
              ),
            );
            BorderedButton(
              child: Icon(Icons.menu, color: Theme.of(context).primaryColor),
              height: 28,
              width: 32,
            ))),
    itemBuilder: (context) {
      return const [
        PopupMenuItem<AppbarActionMenu>(
          value: AppbarActionMenu.SUPPORT,
          child: Text('Contact Support',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
        ),
        PopupMenuItem<AppbarActionMenu>(
          value: AppbarActionMenu.SHARE_ALL_MEDIA,
          child: Text('Share All Images',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
        ),
        PopupMenuItem<AppbarActionMenu>(
          value: AppbarActionMenu.SAVE_TO_GALLERY,
          child: Text('Save Images To Gallery',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
        ),
        PopupMenuItem<AppbarActionMenu>(
          value: AppbarActionMenu.DELETE,
          child: Text('Delete Inspection',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.red,
              )),
        ),
      ];
    },
    onSelected: (value) async {
      switch (value) {
        case AppbarActionMenu.DELETE:
          _onDeletePressed();
          break;

        case AppbarActionMenu.SUPPORT:
          _onSupportPressed();
          break;

        case AppbarActionMenu.SHARE_ALL_MEDIA:
          _onShareAllMediaPressed();
          break;

        case AppbarActionMenu.SAVE_TO_GALLERY:
          final dir = await this.inspection.photosDir();
          if (dir == null) break;
          final album = this.inspection.displayAddress ?? "Rentfind Inspector";

          await showDialog(
              context: context,
              builder: (context) {
                return FutureBuilder<bool>(
                  future: RfiCamera2.backupImages(dir.path, album),
                  builder: (context, snapshot) {
                    final title = snapshot.data != true ? "Saving images..." : "Images saved.";
                    return AlertDialog(
                      title: Text(title),
                      content: snapshot.data != true ? const CircularProgressIndicator() : null,
                      actions: [
                        TextButton(
                          child: const Text("Okay"),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                );
              });

          break;

        default:
          break;
      }
    },
  );
}
