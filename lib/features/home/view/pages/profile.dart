import 'package:flutter/material.dart';
import 'package:jurai/features/auth/models/advogado.dart';
import 'package:jurai/features/auth/view/pages/homepage.dart';
import 'package:jurai/features/home/view/pages/change_password.dart';
import 'package:jurai/features/home/view/pages/devs.dart';
import 'package:jurai/features/home/view/pages/personal_information.dart';
import 'package:jurai/features/home/view/pages/privacy_policy.dart';
import 'package:jurai/features/home/view/pages/profile_details.dart';
import 'package:jurai/features/home/view/widgets/profile_options_button.dart';

class Profile extends StatelessWidget {
  final Advogado? advogado;

  const Profile({super.key, required this.advogado});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configurações", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF387FB9)),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileDetails(advogado: advogado)));
                }, 
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: ClipOval(
                        child: Image.network(
                          "http://127.0.0.1:5001/advogado/${advogado!.id.toString()}/pfp",
                          width: 70, 
                          height: 70, 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(advogado!.username, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(56, 127, 185, 0.750),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text("Advogado", style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.navigate_next, color: Colors.white, size: 30,)
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                color: Colors.white, height: 1,
                margin: EdgeInsets.symmetric(horizontal: 20,),
              ),
              SizedBox(height: 5,),
              //ProfileOptionsButton(text: "Informações Pessoais", preffixIcon: Icons.account_circle, destiny: PersonalInformation()),
              ProfileOptionsButton(text: "Alteração de Senha", preffixIcon: Icons.lock_outline, destiny: ChangePassword()),
              ProfileOptionsButton(text: "Política de Privacidade", preffixIcon: Icons.privacy_tip_outlined, destiny: PrivacyPolicy()),
              ProfileOptionsButton(text: "Desenvolvedores", preffixIcon: Icons.code, destiny: Devs()),
              ProfileOptionsButton(text: "Sair da Conta", preffixIcon: Icons.logout, quit: true, isLast: true, destiny: Homepage()),
              Spacer(),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Image.asset('img/jurai-name.png', scale: 5.5),
              ),
              Text("A inteligência que facilita o processo | © 2025 JurAI", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center,),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
