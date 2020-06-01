import 'dart:io';

import 'package:chat/screens/Loading.dart';
import 'package:chat/services/authservice.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SignUp extends StatefulWidget {
  final Function togglePage;
  SignUp({this.togglePage});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name = "";
  String _email = "";
  String _pass = "";
  int _age;
  int groupVal = 0;
  String gender;
  final _formkey = GlobalKey<FormState>();
  AuthServices _services = AuthServices();
  bool loading = false;
  List<int> ages = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];
  File _image;
  String filename;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      filename = image != null ? basename(image.path) : null;
      print(filename);
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text("SignUp"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      return widget.togglePage();
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    label: Text(
                      "SignIn",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow,
                              ),
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                            ),
                            Container(
                              child: Opacity(
                                opacity: 0.5,
                              ),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 20.0, color: Colors.red)),
                            ),
                            Positioned(
                                top: 150,
                                bottom: 0,
                                left: 80,
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_enhance,
                                    size: 28,
                                    color: Colors.white70,
                                  ),
                                  onPressed: getImage,
                                ))
                          ],
                        )),
                    TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Enter username",
                            hintStyle: TextStyle(color: Colors.redAccent),
                            labelStyle: TextStyle(color: Colors.redAccent),
                            labelText: "Username"),
                        onChanged: (val) {
                          setState(() {
                            _name = val;
                          });
                        },
                        onSaved: (val) {
                          _name = val;
                        },
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter valid value";
                          }
                        }),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter email",
                          hintStyle: TextStyle(color: Colors.redAccent),
                          labelStyle: TextStyle(color: Colors.redAccent),
                          labelText: "Email"),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter valid value";
                        }
                      },
                      onSaved: (val) {
                        _email = val;
                      },
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                    DropdownButtonFormField<int>(
                      value: _age,
                      items: ages.map((e) {
                        return DropdownMenuItem<int>(
                          value: e,
                          child: Text("$e"),
                        );
                      }).toList(),
                      onChanged: (int val) {
                        setState(() {
                          _age = val;
                        });
                      },
                    ),
                    TextFormField(
                      onSaved: (val) {
                        _pass = val;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.redAccent),
                          labelStyle: TextStyle(color: Colors.redAccent),
                          hintText: "Enter password",
                          focusColor: Colors.blue,
                          labelText: "Password"),
                      onChanged: (val) {
                        setState(() {
                          _pass = val;
                        });
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter valid value";
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                          activeColor: Colors.redAccent,
                          value: 0,
                          groupValue: groupVal,
                          onChanged: (val) {
                            setState(() {
                              groupVal = val;
                            });
                          },
                        ),
                        new Text(
                          'Male',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          activeColor: Colors.redAccent,
                          value: 1,
                          groupValue: groupVal,
                          onChanged: (val) {
                            setState(() {
                              groupVal = val;
                            });
                          },
                        ),
                        new Text(
                          'Female',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        elevation: 5.0,
                        color: Colors.red,
                        child: Text(
                          "SignUp",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          gender = groupVal == 0 ? "Male" : "Female";

                          final _formstate = _formkey.currentState;
                          if (_formstate.validate()) {
                            setState(() {
                              loading = true;
                            });
                            _formstate.save();
                          }
                          final result = _services.signUp(_email, _pass, _name,
                              gender, _age, filename, _image);
                          if (result == null) {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
