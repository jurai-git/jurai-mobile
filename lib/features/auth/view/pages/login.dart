import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/homepage.dart';
import 'package:jurai/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';
import 'package:jurai/features/home/view/pages/userhome.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

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
                builder: (context) => const Homepage(),
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
                    // Add TextFormFields and ElevatedButton here.
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
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
                            return "O campo do nome de usuário é de preenchimento obrigatório!";
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
                          hintText: "Nome de usuário",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
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
                        textAlignVertical: TextAlignVertical(y: -.5),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                            icon: Image.asset(
                              isHidden
                                  ? "img/invisiblePassword.png"
                                  : "img/visiblePassword.png",
                            ),
                            color: Colors.white,
                            onPressed: () {
                              isHidden = !isHidden;
                              setState(() {});
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
                              Checkbox(
                                value: isChecked,
                                side: BorderSide(color: Colors.white),
                                activeColor: Color(0xFF387FB9),
                                onChanged: (newBool) {
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
