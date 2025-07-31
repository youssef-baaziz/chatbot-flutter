import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("images/youssef.jpeg"),
            radius: 50,
          ),
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.black,
          Theme.of(context).primaryColor,
        ],
      )),
    );
  }
}
