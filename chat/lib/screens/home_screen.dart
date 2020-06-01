import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/model/homelist.dart';
import 'package:chat/model/profile_data.dart';
import 'package:chat/screens/Loading.dart';
import 'package:chat/screens/profileTIle.dart';
import 'package:chat/services/authservice.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProfileData>>.value(
      value: Database().getAllData,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    authServices.signOut();
                  },
                  icon: Icon(Icons.person_outline),
                  label: Text("Signout"))
            ],
          ),
          body: HomeList()),
    );
  }
}
