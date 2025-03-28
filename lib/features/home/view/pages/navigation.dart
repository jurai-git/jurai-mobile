import 'package:flutter/material.dart';
import 'package:jurai/features/home/view/pages/analysis.dart';
import 'package:jurai/features/home/view/pages/clients.dart';
import 'package:jurai/features/home/view/pages/devs.dart';
import 'package:jurai/features/home/view/pages/documents.dart';
import 'package:jurai/features/auth/view/pages/homepage.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/home/view/pages/userhome.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomBotNavBar(),
      debugShowCheckedModeBanner: false
      );
  }
}

class CustomBotNavBar extends StatefulWidget {
  const CustomBotNavBar({super.key});

  @override
  State<CustomBotNavBar> createState() => CheckState();
}

class CheckState extends State<CustomBotNavBar> {
  int selectedIndex = 0;

  static const List<Widget> pages = <Widget>[UserHome(), Clients(), Documents(), Analysis(), Devs()];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: pages.elementAt(selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromRGBO(25, 24, 29, 1),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF387FB9),
          selectedFontSize: 20,
          unselectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 35),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description, size: 35),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 35),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code, size: 35),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
