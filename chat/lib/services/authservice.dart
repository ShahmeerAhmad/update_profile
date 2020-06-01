import 'dart:io';

import 'package:chat/model/user.dart';
import 'package:chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

//get User id
  User _getUid(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user => _auth.onAuthStateChanged.map(_getUid);
  //imagepost

  //signup
  Future signUp(String email, pass, name, gender, int age, String filename,
      File image) async {
    var url;
    try {
      if (filename != null) {
        StorageReference reference =
            await FirebaseStorage.instance.ref().child("Profile/$filename");
        StorageUploadTask uploadTask = reference.putFile(image);
        var downurl = await (await uploadTask.onComplete).ref.getDownloadURL();
        url = downurl.toString();
      }
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = result.user;
      await Database(uid: user.uid).updataData(name, email, gender, age, url);
      return _getUid(user);
    } catch (e) {
      print(e.toString());
    }
  }

//signn
  Future signIn(String email, pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _getUid(user);
    } catch (e) {
      print(e.toString());
    }
  }
//signin Annonymous

  Future signInAnno() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _getUid(user);
    } catch (e) {
      print(e.toString());
    }
  }

  //signout

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
