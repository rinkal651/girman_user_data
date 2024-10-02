import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:girman_user_data/user.dart';

class UserDataListListView extends StatelessWidget {
  final List<User> items;
  final void Function(User) onItemPressed;

  const UserDataListListView(
      {super.key, required this.items, required this.onItemPressed});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.items.length,
      itemBuilder: (context, index) {
        final user = this.items[index];
        return UserListItem(
          user,
          onTap: () => this.onItemPressed(user),
        );
      },
    );
  }

  UserListItem(User user, {onTap}) {
    ImageProvider imageProvider = AssetImage('assets/images/user_img.png');
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider // Blue line when selected,
                  ),
              Text(
                user.first_name + " " + user.last_name,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 27,
                    color: Color.fromARGB(255, 9, 9, 11)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/location.svg',
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(255, 66, 87, 99), BlendMode.srcIn),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(user.city,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Color.fromARGB(255, 66, 87, 99)))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/call_icon.svg',
                                  colorFilter: ColorFilter.mode(
                                      Color.fromARGB(255, 0, 0, 0),
                                      BlendMode.srcIn),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(user.contact_number,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.38,
                                        color: Color.fromARGB(255, 0, 0, 0)))
                              ]),
                          Text(
                            "Available on phone",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 8.65,
                                color: Color.fromARGB(255, 175, 175, 175)),
                          ),
                        ]),
                        TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Set your desired radius here
                              ),
                              backgroundColor: Color.fromARGB(255, 24, 24, 27)),
                          onPressed: () {
                            onItemPressed(user);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "Fetch Details",
                              style: TextStyle(
                                  fontSize: 12.11,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 250, 250, 250)),
                            ),
                          ),
                        )
                      ]),
                ],
              ),
            ],
          ),
        ));
  }
}
