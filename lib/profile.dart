import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jurai/homepage.dart';
import 'package:jurai/userhome.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Conta"),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          //leading: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));}, child: Icon(Icons.navigate_before, color: Colors.white,)),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                child: Image.asset("img/profile.png", scale: 0.7),
              ),
              Container(
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
                      Icon(Icons.account_circle, color: Colors.white, size: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Informações Pessoais",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next, color: Colors.white, size: 30),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                      width: 1,
                    ),
                  ),
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
                      Icon(Icons.lock, color: Colors.white, size: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Privacidade e Segurança",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next, color: Colors.white, size: 30),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  //border: Border.symmetric(horizontal: BorderSide(color: const Color.fromRGBO(255, 255, 255, 0.5), width: 1))
                ),
                child: Builder(builder: (context) => 
                ElevatedButton(
                  onPressed: () {
                    Scaffold.of(context).showBottomSheet(
                      (context) => Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            )
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            //color: Colors.transparent,
                            color: Color.fromRGBO(25, 24, 29, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Você tem certeza que deseja sair da conta?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).hideCurrentSnackBar();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Homepage(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        //background
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width / 3,
                                          100,
                                        ),
                                      ),
                                      child: Text("Sair"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width / 3,
                                          100,
                                        ),
                                      ),
                                      child: Text("Ficar"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    backgroundColor: Colors.transparent);
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Color.fromARGB(255, 25, 24, 29),
                    padding: EdgeInsets.all(25),
                    shape: LinearBorder(),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Sair da Conta",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next, color: Colors.red, size: 30),
                    ],
                  ),
                ),
                ),
              ),
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
