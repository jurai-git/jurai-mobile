import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  
  final Function(bool?)? onTapCheck;
  final bool? value;
  
  const CustomCheckBox({super.key, required this.value, required this.onTapCheck});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
            value: widget.value,
            side: BorderSide(color: Colors.white),
            activeColor: Color(0xFF387FB9),
            onChanged: widget.onTapCheck,
          );
  }
}