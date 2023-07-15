// ignore: file_names
import 'package:flutter/material.dart';
import 'login.dart';
import 'RegisterPage.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool startlogin = true;
  void togglescreens() {
    setState(() {
      startlogin = !startlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (startlogin) {
      return LoginPage(register: togglescreens);
    } else {
      return RegisterPage(showlogin: togglescreens);
    }
  }
}
