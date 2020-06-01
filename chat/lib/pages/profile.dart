import 'package:chat/model/profile_data.dart';
import 'package:chat/pages/update_profile.dart';
import 'package:chat/screens/Loading.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile({this.uid});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileData>(
        stream: Database(uid: widget.uid).getProData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProfileData prodata = snapshot.data;
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(prodata.name),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.symmetric(
                            horizontal: 80.0, vertical: 70.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: prodata.url != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  placeholderFadeInDuration: Duration(milliseconds: 5000),
                                  fadeInDuration: Duration(seconds: 2),
                                  imageUrl: prodata.url,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Loading(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Username"),
                                Text(prodata.name)
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Email"),
                                Text(prodata.email)
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Gender"),
                                Text(prodata.gender)
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Age"),
                                Text("${prodata.age}")
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: RaisedButton(
                                shape: StadiumBorder(),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                                elevation: 5.0,
                                color: Colors.red,
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return UpdateProfile(
                                    uid: widget.uid,
                                  );
                                })),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
