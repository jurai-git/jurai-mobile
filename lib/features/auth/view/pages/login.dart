import 'package:flutter/material.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';
import 'package:jurai/features/home/view/pages/userhome.dart';

final _formKey = GlobalKey<FormState>();

class Login extends StatelessWidget {
  const Login({super.key});

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
                child: Image.asset('img/jurailogo.png', scale: 1.0),
              ),

              Image.asset('img/jurai-name_resized.png', scale: 3.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 35, 0, 20),
                    child: Row(
                      children: [
                        Text(
                          "Bem-Vindo(a)  ",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "de volta",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                      "Insira suas credenciais para\nefetuar o login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              LoginForm(),
              Spacer(),
              Container(
            margin: EdgeInsets.only(bottom: 40),
            width: MediaQuery.of(context).size.width - 200,
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(56, 127, 185, 0.750),
                ),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Navigation()),
                  );
                }
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
            ],
          ),
        ),
      ),
    );
  }
}

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => CheckState();
}

class CheckState extends State<Check> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      side: BorderSide(color: Colors.white),
      activeColor: Color(0xFF387FB9),
      onChanged: (newBool) {
        setState(() {
          isChecked = newBool;
        });
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<LoginForm> {
  
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add TextFormFields and ElevatedButton here.
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
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "O campo e-mail é de preenchimento obrigatório!";
                } else if (!new RegExp(
                  "(?:[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x20\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])",
                ).hasMatch(value)) {
                  return "O campo e-mail está inválido";
                }

                return null;
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Image.asset('img/email.png'),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 10,
                  minHeight: 10,
                ),
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
            child: TextFormField(
              textAlignVertical: TextAlignVertical(y: -.5),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "O campo senha é de preenchimento obrigatório!";
                }
                return null;
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Image.asset('img/password.png'),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 10,
                  minHeight: 10,
                ),
                fillColor: Colors.transparent,
                border: InputBorder.none,
                hintText: "Senha",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                    icon: Image.asset(isHidden ? "img/invisiblePassword.png" : "img/visiblePassword.png"),
                    color: Colors.white,
                    onPressed: (){
                      isHidden = !isHidden;
                      setState(() {
                        
                      });
                  }, 
                ),
              ),
              style: TextStyle(color: Colors.white),
              obscureText: isHidden,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Check(),
                    Text(
                      "Manter-me conectado",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text(
                "Esqueci minha senha",
                style: TextStyle(
                  color: Color(0xFF387FB9),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
