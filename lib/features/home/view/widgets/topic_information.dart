import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopicInformation extends StatelessWidget {
  final String topicName;
  final String topicData;
  final String topicImage;
  final bool first;

  const TopicInformation({
    super.key,
    required this.topicName,
    required this.topicData,
    required this.topicImage,
    this.first=false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: first ? EdgeInsets.symmetric(vertical: 20) : EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: topicData,
        style: const TextStyle(color: Colors.white),
        enabled: false,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: SvgPicture.asset(
              topicImage,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(Color(0xFF387FB9), BlendMode.srcIn),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 20,
            minHeight: 20,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: topicName,
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}