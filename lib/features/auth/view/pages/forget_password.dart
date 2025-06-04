import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/auth/view/widgets/customtextfield.dart';
import 'package:jurai/features/auth/view/widgets/gradientbg.dart';
import 'package:jurai/features/auth/view/widgets/loading_circle.dart';
import 'package:jurai/features/auth/viewmodel/auth_viewmodel.dart';

class ForgetPassword extends ConsumerStatefulWidget {
  const ForgetPassword({super.key});

  @override
  ConsumerState<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<ForgetPassword> {
  final _passwordResetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSuccessWidget = false;
  Color staticColorButton = Color.fromRGBO(56, 127, 185, 0.750);
  Widget buttonChild = Text("Enviar E-mail", style: TextStyle(color: Colors.white, fontSize: 16),);
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            setState(() {
              showSuccessWidget = true;
            });
          },
          error: (error, st) {
            staticColorButton = Color.fromRGBO(56, 127, 185, 0.750);
            buttonChild = Text("Enviar E-mail", style: TextStyle(color: Colors.white, fontSize: 16),);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
            isEnabled = true;
          },
          loading: () {
            isEnabled = false;
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: showSuccessWidget ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset('img/jurailogo.png', width: 200, fit: BoxFit.contain,),
                  ),
                  Text("E-mail enviado com sucesso!", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Text("Cheque seu e-mail e sua caixa de spam para prosseguir com o processo de recuperação!", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFF387FB9)),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                      padding: EdgeInsets.symmetric(vertical: 20)
                    ),
                    child: Text(
                      "Retornar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    ),
                  ),
                ],
              )
              : 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset('img/jurailogo.png', width: 200, fit: BoxFit.contain,),
                  ),
                  Text("Recuperação de Senha", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Text("Insira seu email no campo abaixo para começarmos o processo de recuperação de senha", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: CustomTextField(textController: _passwordResetController, type: "email", enabled: isEnabled,), 
                  ),
                  Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: staticColorButton,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          staticColorButton = Color.fromRGBO(31, 71, 104, 0.749);
                          buttonChild = SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator.adaptive(strokeWidth: 3),
                          );
                        });
                        await ref
                          .read(authViewModelProvider.notifier)
                            .resetPasswordUser(email: _passwordResetController.text);
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
                    child: Text("Voltar para o Login", style: TextStyle(color: Colors.white),) 
                  )
                ],
              )
            )
          )
        ),
      ),
    );
  }
}