import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String profileName;
  final String profilePictureUrl;
  final String profileRole;

  const ProfileCard(
    {
      super.key, 
      required this.profileName, 
      required this.profilePictureUrl, 
      required this.profileRole
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
        Flexible(
          child: FittedBox(
              child: Text(profileName, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          )
        ),
        Flexible(
          child: FittedBox(
            child: AutoSizeText(profileRole, style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
          )
        )
      ],
    );
  }
}