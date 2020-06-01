import 'package:chat/model/user.dart';
import 'package:chat/pages/find_friends.dart';
import 'package:chat/pages/profile.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthServices authServices = AuthServices();

  int currnt = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List _page = [HomeScreen(), Profile(uid: user.uid), FindFriend()];
    return Scaffold(
      body: _page[currnt],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currnt,
        onTap: (index) {
          setState(() {
            currnt = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), title: Text("Friends")),
        ],
      ),
    );
  }
}
