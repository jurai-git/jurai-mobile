import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String profileName;
  final String profilePictureUrl;
  final String profileAge;

  const ProfileCard(
    {
      super.key, 
      required this.profileName, 
      required this.profilePictureUrl, 
      required this.profileAge
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 32, 31, 36), width: 5),
            shape: BoxShape.circle
          ),
          margin: EdgeInsets.only(top: 20),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(profilePictureUrl),
            backgroundColor: Colors.transparent,
          ),
        ),
        Text(profileName, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
        Text("$profileAge anos", style: TextStyle(color: Colors.white, fontSize: 20),),
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("img/icons8-github-30.png", scale: .75),
              Image.asset("img/icons8-linkedin-30.png", scale: .8),
              Image.asset("img/icons8-instagram-30.png", scale: .8)
          ],
        )
        )
      ],
    );
  }
}