import 'package:chat/model/profile_data.dart';
import 'package:chat/screens/profileTIle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<List<ProfileData>>(context) ?? [];
    return ListView.builder(
      itemCount: profile.length,
      itemBuilder: (context, index) {
        return ProfileTile(
          profileData: profile[index],
        );
      },
    );
  }
}
