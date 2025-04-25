import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopicInformation extends StatelessWidget {
  final String topicName;
  final String topicData;
  final String topicImage;

  const TopicInformation({super.key, required this.topicName, required this.topicData, required this.topicImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF387FB9),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: SvgPicture.asset(topicImage, width: 30, height: 30,),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(topicName, style: TextStyle(color: const Color.fromRGBO(255, 255, 255, .5), fontSize: 12), textAlign: TextAlign.left,),
            Text(topicData, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.left,),
          ]
        )
      ],
    );
  }
}