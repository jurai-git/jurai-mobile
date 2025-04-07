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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Image.asset('img/jurailogo.png', scale: 0.7),
              ),

              Image.asset('img/jurai-name_resized.png', scale: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Otimize seu tempo\nde trabalho",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Faça consultas, altere informações,",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "analise documentos, tudo na ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "palma da sua mão",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width - 200,
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
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
                    fixedSize: Size.fromWidth(250),
                    padding: EdgeInsets.all(25),
                  ),
                  child: Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 200,
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
                    fixedSize: Size.fromWidth(250),
                    padding: EdgeInsets.all(25),
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
    );
  }
}
