import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat/model/profile_data.dart';
import 'package:chat/screens/Loading.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final ProfileData profileData;
  ProfileTile({this.profileData});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              placeholderFadeInDuration: Duration(milliseconds: 5000),
              fadeInDuration: Duration(seconds: 2),
              imageUrl: profileData.url,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => Loading(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(profileData.name),
          subtitle: Text(profileData.gender),
        ),
      ),
    );
  }
}
