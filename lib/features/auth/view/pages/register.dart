import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/auth/view/widgets/customtextfield.dart';
import 'package:jurai/features/auth/view/widgets/gradientbg.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/auth/viewmodel/auth_viewmodel.dart';

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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
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
        gradient: GradientBg(),
      ),
      child: isLoading? Center(child: LoadingCircle(),) : Scaffold(
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
                  CustomTextField(
                    textController: usernameController,
                    type: "username",
                  ),
                  CustomTextField(
                    textController: oabController,
                    type: "oab",
                  ),
                  CustomTextField(
                    textController: emailController,
                    type: "email",
                  ),
                  CustomTextField(
                    textController: passwordController,
                    type: "password",
                    obscureText: isHidden,
                    showSuffix: true,
                    onSuffixTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                  ),
                  CustomTextField(
                    textController: confirmPasswordController,
                    type: "confirmPassword",
                    obscureText: isConfirmHidden,
                    showSuffix: true,
                    onSuffixTap: () {
                      setState(() {
                        isConfirmHidden = !isConfirmHidden;
                      });
                    },
                  ),
                ],
              ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
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
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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