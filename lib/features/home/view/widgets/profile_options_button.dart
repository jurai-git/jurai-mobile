import 'package:flutter/material.dart';

class ProfileOptionsButton extends StatefulWidget {
  final String text;
  final IconData preffixIcon;
  final IconData suffixIcon;
  final bool quit;

  const ProfileOptionsButton({
    super.key,
    required this.text,
    required this.preffixIcon,
    required this.suffixIcon,
    this.quit = false
  });

  @override
  State<ProfileOptionsButton> createState() => _ProfileOptionsButtonState();
}

class _ProfileOptionsButtonState extends State<ProfileOptionsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        //border: Border.symmetric(horizontal: BorderSide(color: const Color.fromRGBO(255, 255, 255, 0.5), width: 1))
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromRGBO(25, 24, 29, 1),
          padding: EdgeInsets.all(25),
          shape: LinearBorder(),
        ),
        child: Row(
          children: [
            Icon(widget.preffixIcon, color: widget.quit ? Colors.red : Colors.white, size: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.text,
                style: TextStyle(color: widget.quit ? Colors.red : Colors.white, fontSize: 18),
              ),
            ),
            Spacer(),
            Icon(widget.suffixIcon, color: widget.quit ? Colors.red : Colors.white, size: 30),
          ],
        ),
      ),
    );
  }
}
