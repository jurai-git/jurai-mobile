import 'package:flutter/material.dart';
import 'package:jurai/homepage.dart';
import 'package:jurai/login.dart';
import 'package:jurai/profile.dart';
import 'package:jurai/register.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50, top: 50),
                    child: Image.asset('img/jurai-name.png', scale: 4.0),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 50, top: 50),
                    child: ElevatedButton(
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.amber,
                      ),
                      child: Image.asset("img/profile.png"),
                    ),
                  ),
                ],
              ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                    child: Text(
                      "Olá, {advogado.username}",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ],
              ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "O que deseja fazer hoje?",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
                    child: Text(
                      "Acessos Recentes",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBotNavBar()
      ),
    );
  }
}

class CustomBotNavBar extends StatefulWidget {
  const CustomBotNavBar({Key? key}) : super(key: key);

  @override
  State<CustomBotNavBar> createState() => CheckState();
}

class CheckState extends State<CustomBotNavBar> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
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
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 35,), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 35,), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.description, size: 35,), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search, size: 35,), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.code, size: 35,), label: ""),
          ]
    );
  }
}

const List<Widget> pages = <Widget>[
  Register(),
  Login(),
  Homepage()
];