import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/drawer.header.widget.dart';
import 'package:flutter_chat_app/widgets/drawer.item.widget.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          MyDrawerHeader(),
          MyDrawerItem(
            title: "Home",
            itemIcon: Icon(Icons.home),
            route: "/home",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          MyDrawerItem(
            title: "Counter",
            itemIcon: Icon(Icons.person),
            route: "/counter",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          MyDrawerItem(
            title: "Chat",
            itemIcon: Icon(Icons.chat_bubble_outline),
            route: "/chat",
          ),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          Spacer(),
          Divider(
            height: 1,
            color: Theme.of(context).primaryColor,
          ),
          MyDrawerItem(
            title: "Logout",
            itemIcon: Icon(Icons.login,
                color: const Color.fromARGB(218, 209, 130, 1)),
            route: "/login",
          ),
        ],
      ),
    );
  }
}
