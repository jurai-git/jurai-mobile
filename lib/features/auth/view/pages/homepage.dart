import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/auth/view/pages/register.dart';
import 'package:jurai/features/auth/view/widgets/gradientbg.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: GradientBg()
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.all(15),
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Image.asset('img/jurailogo.png', width: 200, fit: BoxFit.contain,),
                  ),
              
                  Image.asset('img/jurai-name_resized.png', width: 250, fit: BoxFit.contain,),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *0.8,
                        padding: EdgeInsets.all(20),
                        child: AutoSizeText(
                          "Otimize seu tempo de trabalho",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *0.8,
                        padding: EdgeInsets.only(left: 12, right: 12, bottom: 20),
                          child: Column(
                          children: [
                            AutoSizeText(
                              "Faça consultas, altere informações, analise documentos, tudo na palma da sua mão",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ],
                          ),

                            ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF387FB9)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                      ),
                      child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromRGBO(56, 127, 185, 0.750),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Register()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                      ),
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
      )
    );
  }
}
