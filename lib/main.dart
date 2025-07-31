import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/chat.page.dart';
import 'package:flutter_chat_app/pages/counter.page.dart';
import 'package:flutter_chat_app/pages/home.page.dart';
import 'package:flutter_chat_app/pages/login.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        "/home": (context) => MyHomePage(),
        "/counter": (context) => CounterPage(),
        "/chat": (context) => ChatPage(),
        "/login": (context) => LoginPage(),
      },
      theme: ThemeData(
          textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 22, color: Colors.black)),
          indicatorColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            primary: Colors.teal,
          )),
    );
  }
}
