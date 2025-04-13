import 'package:flutter/material.dart';
import 'package:jurai/features/auth/view/pages/homepage.dart';
import 'package:jurai/features/home/view/pages/personal_information.dart';
import 'package:jurai/features/home/view/pages/privacy_security.dart';
import 'package:jurai/features/home/view/widgets/profile_options_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        //appBar: AppBar(
          //title: Text("Conta"),
          //titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          //centerTitle: true,
          //iconTheme: IconThemeData(color: Colors.white),
          //leading: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));}, child: Icon(Icons.navigate_before, color: Colors.white,)),
          //backgroundColor: Colors.transparent,
        //),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                child: Text("Conta", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Image.asset('img/jurai-name.png', scale: 5.5),
              ),
              Container(
                padding: EdgeInsets.all(80),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: Image.asset("img/profile.png", scale: 0.7),
              ),
              ProfileOptionsButton(text: "Informações Pessoais", preffixIcon: Icons.account_circle, destiny: PersonalInformation()),
              ProfileOptionsButton(text: "Privacidade e Segurança", preffixIcon: Icons.lock, destiny: PrivacySecurity()),
              ProfileOptionsButton(text: "Sair da Conta", preffixIcon: Icons.logout, quit: true, isLast: true, destiny: Homepage()),
              
            ],
          ),
        ),
        //bottomNavigationBar: Container(
        //padding: EdgeInsets.all(10),
        //child: Text("A inteligência que facilita o processo | © 2024 JurAI", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center,),
        //),
      ),
    );
  }
}
