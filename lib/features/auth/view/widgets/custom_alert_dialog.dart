import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  const CustomAlertDialog({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
      title: Text(title, style: TextStyle(color: Colors.white),),
      content: Text(content, style: TextStyle(color: const Color.fromRGBO(255, 255, 255, .75)),),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
          child: Text('Entendi'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}