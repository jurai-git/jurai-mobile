import 'package:flutter/material.dart';
import 'package:jurai/navigation.dart';
import 'package:jurai/userhome.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(1, 1),
          transform: GradientRotation(45),
          colors: [
            Color.fromRGBO(25, 24, 29, 1),
            Color.fromRGBO(12, 58, 96, 1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('img/jurailogo.png', scale: 1.3),
                    Image.asset('img/jurai-name_resized.png', scale: 2.0),
                ],)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 20),
                    child: Text(
                      "Olá, seja bem-vindo(a)",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Insira suas credenciais para\nefetuar o registro",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(1, 1),
                    colors: [Color(0x3E387FB9), Color(0x3E2B2932)],
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('img/profile.png',),
                    prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText: "Nome Completo",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(1, 1),
                    colors: [Color(0x3E387FB9), Color(0x3E2B2932)],
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('img/oab.png',),
                    prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText: "Nº OAB",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(1, 1),
                    colors: [Color(0x3E387FB9), Color(0x3E2B2932)],
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('img/email.png',),
                    prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(1, 1),
                    colors: [Color(0x3E387FB9), Color(0x3E2B2932)],
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('img/password.png',),
                    prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(1, 1),
                    colors: [Color(0x3E387FB9), Color(0x3E2B2932)],
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('img/password.png',),
                    prefixIconConstraints: BoxConstraints(minWidth: 10, minHeight: 10),
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    hintText: "Confirmar Senha",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    colors: [
                      Color(0xFF387FB9),
                      Color(0xFF387FB9),
                      Color(0xFF387FB9),
                      Color(0x3E1E1E1E),
                    ],
                  ),
                ),
                  child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Navigation()));}, style: ButtonStyle(backgroundColor: WidgetStateColor.transparent, fixedSize: WidgetStateProperty.all(Size.fromWidth(250)), padding: WidgetStateProperty.all(EdgeInsets.all(30))), child: Text("Criar Conta", style: TextStyle(color: Colors.white),),),
                ),
            ]
          )
        )
      )
    );
  }
}