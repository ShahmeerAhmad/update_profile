import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:chat/model/profile_data.dart';
import 'package:chat/screens/Loading.dart';
import 'package:chat/services/authservice.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  String uid;
  UpdateProfile({this.uid});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String _username;
  String _email;
  String _gender;
  int _age;
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String oldUrl;
  AuthServices authServices = AuthServices();
  Database db = Database();
  File _updataprofile;
  String _filepath;
  Future _updateimage() async {
    var selectimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _updataprofile = selectimage;
      _filepath = _updataprofile != null ? basename(selectimage.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileData>(
      stream: Database(uid: widget.uid).getProData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ProfileData data = snapshot.data;
          return Form(
            key: _formkey,
            child: loading
                ? Loading()
                : Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.red,
                      title: Text("Updata profile"),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.yellow),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: data.url != null
                                          ? _updataprofile != null
                                              ? Image.file(
                                                  _updataprofile,
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  data.url,
                                                  fit: BoxFit.fill,
                                                )
                                          : Icon(
                                              Icons.person,
                                              size: 100,
                                              color: Colors.white,
                                            ),
                                    )),
                                Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.pinkAccent),
                                      child: IconButton(
                                        icon: Icon(Icons.camera_alt),
                                        color: Colors.white,
                                        onPressed: _updateimage,
                                      )),
                                )
                              ],
                            ),
                          ),
                          TextFormField(
                            initialValue: _username ?? data.name,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "enter valid value";
                              }
                            },
                            onChanged: (val) {
                              _username = val;
                            },
                            onSaved: (val) {
                              _username = val;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("${data.email}"),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.black,
                          ),
                          TextFormField(
                            initialValue: _gender ?? data.gender,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "enter valid value";
                              }
                            },
                            onChanged: (val) {
                              _gender = val;
                            },
                            onSaved: (val) {
                              _gender = val;
                            },
                          ),
                          TextFormField(
                            initialValue: _age ?? data.age.toString(),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "enter valid value";
                              }
                            },
                            onChanged: (val) {
                              _age = int.parse(val);
                            },
                            onSaved: (val) {
                              _age = int.parse(val);
                            },
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
                                "SignUp",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                final _formstate = _formkey.currentState;
                                if (_formstate.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  _formstate.save();
                                }
                                oldUrl = _filepath != null
                                    ? data.url != null ? data.url : null
                                    : null;
                                if (oldUrl != null) {
                                  try {
                                    StorageReference reference =
                                        await FirebaseStorage.instance
                                            .getReferenceFromUrl(data.url);
                                    print(reference.path);
                                    await reference.delete();
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                }

                                var url;
                                if (_updataprofile != null) {
                                  try {
                                    StorageReference reference =
                                        await FirebaseStorage.instance
                                            .ref()
                                            .child("Profile/$_filepath");
                                    StorageUploadTask uploadtask =
                                        reference.putFile(_updataprofile);
                                    var donwlUrl =
                                        await (await uploadtask.onComplete)
                                            .ref
                                            .getDownloadURL();
                                    url = donwlUrl.toString();
                                  } catch (e) {}
                                }
                                final result = Database(uid: widget.uid)
                                    .updataData(
                                        _username ?? data.name,
                                        _email ?? data.email,
                                        _gender ?? data.gender,
                                        _age ?? data.age,
                                        url ?? data.url);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
