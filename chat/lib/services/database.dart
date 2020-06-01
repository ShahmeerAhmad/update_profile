import 'package:chat/model/profile_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid;
  Database({this.uid});
  CollectionReference _reference = Firestore.instance.collection("App users");

  Future updataData(
      String name, String email, String gender, int age, String url) async {
    return await _reference.document(uid).setData({
      "name": name,
      "email": email,
      "gender": gender,
      "age": age,
      "url": url
    });
  }

  ProfileData getProfileData(DocumentSnapshot e) {
    return ProfileData(
        name: e.data["name"] ?? "",
        email: e.data["email"] ?? "",
        gender: e.data["gender"] ?? "",
        age: e.data["age"] ?? 0,
        url: e.data["url"] ?? "");
  }

  Stream<ProfileData> get getProData {
    return _reference.document(uid).snapshots().map(getProfileData);
  }

  List<ProfileData> getAll(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ProfileData(
          name: doc.data["name"] ?? "",
          gender: doc.data["gender"] ?? "",
          url: doc.data["url"] ?? "");
    }).toList();
  }

  Stream<List<ProfileData>> get getAllData {
    return _reference.snapshots().map(getAll);
  }
}
