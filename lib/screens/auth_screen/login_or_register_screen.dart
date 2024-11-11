import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lock_words/screens/auth_screen/login_screen.dart';
import 'package:lock_words/screens/auth_screen/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {

  late bool showLoginScreen = true;

  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      print("login");
      return LoginScreen(onTap: toggleScreens,);
    } else {
      print("register");
      return RegisterScreen(onTap: toggleScreens,);
    }
  }
}