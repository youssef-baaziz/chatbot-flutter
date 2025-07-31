import 'package:flutter/material.dart';

class MyDrawerItem extends StatelessWidget {
  final String title;
  final Icon itemIcon;
  final String route;
  const MyDrawerItem({
    super.key,
    required this.title,
    required this.itemIcon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleTextStyle: TextStyle(color: Colors.black),
      leading: itemIcon,
      trailing: Icon(Icons.arrow_forward),
      title: Text("$title"),
      iconColor: Color.fromARGB(255, 35, 147, 96),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, route);
      },
    );
  }
}
