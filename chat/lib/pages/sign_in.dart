import 'package:chat/screens/Loading.dart';
import 'package:chat/services/authservice.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function togglePage;
  SignIn({this.togglePage});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthServices _authServices = AuthServices();
  String _email = "";
  String _pass = "";
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: Text("Sign In"),
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
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
              body: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 80.0),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Enter email",
                              hintStyle: TextStyle(color: Colors.redAccent),
                              labelStyle: TextStyle(color: Colors.redAccent),
                              labelText: "Email"),
                          onChanged: (val) {
                            setState(() {
                              _email = val;
                            });
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter valid value";
                            }
                          }),
                      TextFormField(
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
                      SizedBox(
                        height: 30,
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
                            "SignIn",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              setState(() {
                                loading = true;
                              });
                            }
                            final resutl =
                                await _authServices.signIn(_email, _pass);
                            if (resutl == null) {
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
