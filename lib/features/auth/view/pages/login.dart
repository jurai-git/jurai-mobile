import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/forget_password.dart';
import 'package:jurai/features/auth/view/pages/register.dart';
import 'package:jurai/features/auth/view/widgets/custom_alert_dialog.dart';
import 'package:jurai/features/auth/view/widgets/customcheckbox.dart';
import 'package:jurai/features/auth/view/widgets/customtextfield.dart';
import 'package:jurai/features/auth/view/widgets/gradientbg.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isChecked = false;
  bool isHidden = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomBotNavBar(),
              ),
              (_) => false,
            );
          },
          error: (error, st) {
            String title = '';
            String content = '';
            if(error == "ERROR_INVALID_CREDENTIALS"){
              title = "Credenciais Inválidas";
              content = "Verifique o seu nome de usuário e senha e tente fazer o login novamente";
            }
            else{
              title = "Erro do Sistema";
              content = "Por favor, faça o login novamente e, se o erro persistir, tente novamente mais tarde";
            }
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(title: title, content: content,);
              },
            );
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
          child: SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset('img/jurailogo.png', width: 200, fit: BoxFit.contain,),
              ),

              Image.asset('img/jurai-name_resized.png', width: 250, fit: BoxFit.contain,),

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
              Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextField(
                      textController: usernameController, 
                      type: "username"
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: CustomCheckBox(
                            value: isChecked,
                            onTapCheck: (newBool) {
                              setState(() {
                                isChecked = newBool;
                              });
                            },
                          ),
                        ),
                        Text(
                          "Manter-me conectado",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(56, 127, 185, 0.750),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                        .read(authViewModelProvider.notifier)
                          .loginUser(username: usernameController.text, password: passwordController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(vertical: 20)
                  ),
                  child: Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF387FB9)),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ForgetPassword()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                    padding: EdgeInsets.symmetric(vertical: 20)
                  ),
                  child: Text("Esqueci minha senha", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Register()));
                },
                child: Text("Não possuo uma conta", style: TextStyle(color: Colors.white),) 
              )
            ],
          ),
        ),
          )
        )
      ),
    );
  }
}
