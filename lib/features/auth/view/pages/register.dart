import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/homepage.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';
import 'package:jurai/features/home/view/pages/userhome.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => RegisterState();
}

class RegisterState extends ConsumerState<Register>{
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final oabController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isHidden = true, isConfirmHidden = true;

  @override
  void dispose() {
    usernameController.dispose();
    oabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Conta criada com sucesso! Faça login para entrar"))
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          },
          error: (error, st) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
          },
          loading: () {},
        );
      },
    );

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
      child: isLoading? Center(child: CircularProgressIndicator.adaptive(),) : Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('img/jurailogo.png', scale: 1.3),
                    Image.asset('img/jurai-name_resized.png', scale: 2.0),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Olá, seja  ",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "bem-vindo(a)",
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
                      "Insira suas credenciais para\nefetuar o registro",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Form(
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
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O campo nome é de preenchimento obrigatório!";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Color(0xFFD32F2F),
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Image.asset('img/profile.png'),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
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
                    child: TextFormField(
                      controller: oabController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O campo Nº OAB é de preenchimento obrigatório!";
                        } else if (!RegExp("^[0-9]*\$").hasMatch(value)) {
                          return "O campo Nº OAB é composto apenas por números!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          color: Color(0xFFD32F2F),
                          fontWeight: FontWeight.bold,
                        ),
                        prefixIcon: Image.asset('img/oab.png'),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        hintText: "Nº OAB",
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
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O campo e-mail é de preenchimento obrigatório!";
                        } else if (!RegExp(
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
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O campo senha é de preenchimento obrigatório!";
                        }

                        return null;
                      },
                      textAlignVertical: TextAlignVertical(y: -.5),
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
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "O campo confirmar senha é de preenchimento obrigatório!";
                        }
                        return null;
                      },
                      textAlignVertical: TextAlignVertical(y: -.5),
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
                        hintText: "Confirmar Senha",
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                            icon: Image.asset(isConfirmHidden ? "img/invisiblePassword.png" : "img/visiblePassword.png"),
                            color: Colors.white,
                            onPressed: (){
                              isConfirmHidden = !isConfirmHidden;
                              setState(() {
                                
                              });
                          }, 
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: isConfirmHidden,
                    ),
                  ),
                ],
              ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width - 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(56, 127, 185, 0.750),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                        .read(authViewModelProvider.notifier)
                          .signUpUser(
                            username: usernameController.text, 
                            email: emailController.text, 
                            oab: oabController.text, 
                            password: passwordController.text
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