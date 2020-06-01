import 'package:chat/model/toggle_sign.dart';
import 'package:chat/model/user.dart';
import 'package:chat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final result = Provider.of<User>(context);
    if (result == null) {
      return TogglePage();
    } else {
      return HomePage();
    }
  }
}
