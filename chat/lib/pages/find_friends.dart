import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FindFriend extends StatefulWidget {
  @override
  _FindFriendState createState() => _FindFriendState();
}

class _FindFriendState extends State<FindFriend> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Database().getAllData,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Find Friends"),
        ),
      ),
    );
  }
}
