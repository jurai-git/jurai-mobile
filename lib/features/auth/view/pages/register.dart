import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/auth/view/widgets/custom_alert_dialog.dart';
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
  Color staticColorButton = Color.fromRGBO(56, 127, 185, 0.750);
  Widget buttonChild = Text("Criar Conta", style: TextStyle(color: Colors.white, fontSize: 16),);
  bool isHidden = true, isConfirmHidden = true;
  bool isRegisterButtonEnabled = true;

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

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(title: "Cadastro Realizado", content: "Seu cadastro foi realizado com sucesso! Faça login e desfrute das funcionalidades do JurAI",);
              },
            );
          },
          error: (error, st) {
            String title = '';
            String content = '';

            if(error == "ERROR_CONFLICT"){
              title = "Cadastro Inválido";
              content = "Já existe um advogado cadastrado no sistema com esse nome de usuário ou email";
            }
            else{
              title = "Erro do Sistema";
              content = "Por favor, faça o cadastro novamente e, se o erro persistir, tente novamente mais tarde";
            }
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(title: title, content: content,);
              },
            );
            staticColorButton = Color.fromRGBO(56, 127, 185, 0.750);
            buttonChild = Text("Criar Conta", style: TextStyle(color: Colors.white, fontSize: 16),);
            isRegisterButtonEnabled = true;
            setState(() {});
          },
          loading: () {
            isRegisterButtonEnabled = false;
          },
        );
      },
    );

    return Container(
      decoration: BoxDecoration(
        gradient: GradientBg(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('img/jurailogo.png', width: 130, fit: BoxFit.contain,),
                    Image.asset('img/jurai-name_resized.png', width: 230, fit: BoxFit.contain,),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          "Olá, seja  ",
                          style: TextStyle(fontSize: 27, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "bem-vindo(a)",
                          style: TextStyle(
                            fontSize: 27,
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
              Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    textController: usernameController,
                    type: "username",
                    enabled: isRegisterButtonEnabled,
                  ),
                  CustomTextField(
                    textController: oabController,
                    type: "oab",
                    enabled: isRegisterButtonEnabled,
                  ),
                  CustomTextField(
                    textController: emailController,
                    type: "email",
                    enabled: isRegisterButtonEnabled,
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
                    enabled: isRegisterButtonEnabled,
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
                    enabled: isRegisterButtonEnabled,
                  ),
                ],
              ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: staticColorButton,
                ),
                child: ElevatedButton(
                  onPressed: !isRegisterButtonEnabled ? null : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        staticColorButton = Color.fromRGBO(31, 71, 104, 0.749);
                        buttonChild = SizedBox(
                            width: 22,
                            height: 22.5,
                            child: CircularProgressIndicator.adaptive(strokeWidth: 3),
                          );
                      });
                      if(confirmPasswordController.text == passwordController.text){
                      await ref
                        .read(authViewModelProvider.notifier)
                          .signUpUser(
                            username: usernameController.text, 
                            email: emailController.text, 
                            oab: oabController.text, 
                            password: passwordController.text
                            );
                      }
                      else{
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(title: "Erro ao se Cadastrar", content: "As senhas não coincidem. Por favor, verifique as senhas e tente novamente",);
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(vertical: 20)
                  ),
                  child: buttonChild
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                }, 
                child: Text("Já possuo uma conta", style: TextStyle(color: Colors.white),)
              )
            ],
          ),
          )
        ),
      ),
      )
    );
  }
}