import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomCheckBox(
                                value: isChecked,
                                onTapCheck: (newBool) {
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                },
                              ),
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
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 40),
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
                          .loginUser(username: usernameController.text, password: passwordController.text);
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
                    "Entrar",
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
