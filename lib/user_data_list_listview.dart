import 'package:flutter/material.dart';
import 'package:girman_user_data/user.dart';

class UserDataListListView extends StatelessWidget {
  final List<User> items;
  final void Function(User) onItemPressed;

  const UserDataListListView({super.key, required this.items, required this.onItemPressed});
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: this.items.length,
        itemBuilder: (context, index) {
          final user = this.items[index];
          return UserListItem(
            user,
            onTap: () => this.onItemPressed(user),
          );
        },
      ),
    );
  }

  UserListItem(User user, {onTap}) {
    return Card(
      child: Column(
        children: [
          Image.asset("/assets/images/logo.svg"),
        ],
      ),
    );
  }

}
