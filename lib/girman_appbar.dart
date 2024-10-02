import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:girman_user_data/user_list_screen.dart';
import 'package:girman_user_data/user_list_screen_view_model.dart';
import 'package:girman_user_data/webview_screen.dart';

PreferredSizeWidget? GirmanAppbar(BuildContext context,
    {bool displayMenu = false}) {
  return AppBar(
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      elevation: 5.0,
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        height: 35,
      ),
      actions: [
        displayMenu
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                    child: PopupMenuButton<AppBarMenu>(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<AppBarMenu>(
                                value: AppBarMenu.SEARCH,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.blueAccent,
                                              width:
                                                  2)) // Blue line when selected,
                                      ),
                                  child: Text(AppBarMenu.SEARCH.name,
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.52,
                                        fontWeight: FontWeight.w700,
                                      )),
                                )),
                            PopupMenuItem<AppBarMenu>(
                                value: AppBarMenu.WEBSITE,
                                child: Text(AppBarMenu.WEBSITE.name,
                                    style: TextStyle(
                                      fontSize: 14.52,
                                      fontWeight: FontWeight.w400,
                                    ))),
                            PopupMenuItem<AppBarMenu>(
                                value: AppBarMenu.LINKEDIN,
                                child: Text(AppBarMenu.LINKEDIN.name,
                                    style: TextStyle(
                                      fontSize: 14.52,
                                      fontWeight: FontWeight.w400,
                                    ))),
                            PopupMenuItem<AppBarMenu>(
                                value: AppBarMenu.CONTACT,
                                child: Text(AppBarMenu.CONTACT.name,
                                    style: TextStyle(
                                      fontSize: 14.52,
                                      fontWeight: FontWeight.w400,
                                    )))
                          ];
                        },
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: Icon(Icons.menu),
                        ),
                        onSelected: (value) async {
                          switch (value) {
                            case AppBarMenu.WEBSITE:
                              {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WebviewScreen.createInstance(
                                                webConfig: WebConfig.WEBSITE)));
                                return;
                              }
                            case AppBarMenu.LINKEDIN:
                              {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WebviewScreen.createInstance(
                                                webConfig:
                                                    WebConfig.LINKEDIN)));
                                return;
                              }
                            case AppBarMenu.SEARCH:
                              // TODO: Handle this case.
                              return;
                            case AppBarMenu.CONTACT:
                              UserListViewModel.launchEmail();
                          }
                        })),
              )
            : Container()
      ]);
}
