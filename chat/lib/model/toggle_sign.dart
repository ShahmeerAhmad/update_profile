import 'package:chat/pages/sign_in.dart';
import 'package:chat/pages/sign_up.dart';
import 'package:flutter/material.dart';

class TogglePage extends StatefulWidget {
  @override
  _TogglePageState createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool showPage = false;
  void togglePage() {
    setState(() {
      showPage = !showPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showPage) {
      return SignIn(togglePage: togglePage);
    } else {
      return SignUp(
        togglePage: togglePage,
      );
    }
  }
}
