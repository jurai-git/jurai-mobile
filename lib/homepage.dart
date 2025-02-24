import 'package:flutter/material.dart';
import 'package:jurai/login.dart';
import 'package:jurai/register.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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
                  child: Image.asset('img/jurailogo.png', scale: 0.7,),
                ),

                Image.asset('img/jurai-name_resized.png', scale: 1.7,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text("Otimize seu tempo\nde trabalho", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Faça consultas, altere informações,\nanalise documentos, tudo na\npalma da sua mão", style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
                    )
                  ]
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Color(0xFF387FB9)),
                ),
                  child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));}, style: ButtonStyle(backgroundColor: WidgetStateColor.transparent, fixedSize: WidgetStateProperty.all(Size.fromWidth(250)), padding: WidgetStateProperty.all(EdgeInsets.all(30))), child: Text("Entrar", style: TextStyle(color: Colors.white),),),
                ),
                Container(
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
                  child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));}, style: ButtonStyle(backgroundColor: WidgetStateColor.transparent, fixedSize: WidgetStateProperty.all(Size.fromWidth(250)), padding: WidgetStateProperty.all(EdgeInsets.all(30))), child: Text("Criar Conta", style: TextStyle(color: Colors.white),),),
                ),
            ],
            
          )
        ),
      ),
    );
  }
}

