import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/login.dart';
import 'package:jurai/features/auth/view/widgets/custom_alert_dialog.dart';
import 'package:jurai/features/auth/view/widgets/customtextfield.dart';
import 'package:jurai/features/auth/view/widgets/gradientbg.dart';
import 'package:jurai/features/auth/viewmodel/auth_viewmodel.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSuccessWidget = false;
  Color staticColorButton = Color.fromRGBO(56, 127, 185, 0.750);
  Widget buttonChild = Text("Alterar Senha", style: TextStyle(color: Colors.white, fontSize: 16),);
  bool isEnabled = true, isHidden = true, isConfirmHidden = true;
  

  @override
  Widget build(BuildContext context) {

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
            setState((){});
            String title = '';
            String content = '';

            if(error == "ERROR_ADVOGADO_NOT_FOUND"){
              title = "Advogado Não Identificado";
              content = "Esse advogado não foi encontrado no sistema";
            }
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(title: title, content: content,);
              },
            );
            staticColorButton = Color.fromRGBO(56, 127, 185, 0.750);
            buttonChild = Text("Enviar E-mail", style: TextStyle(color: Colors.white, fontSize: 16),);
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
        backgroundColor: Color.fromRGBO(25, 24, 29, 1)  ,
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
                  Text("Alteração de Senha", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Text("Insira sua senha atual e confirme-a nos campos abaixo para começarmos o processo de alteração de senha", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                  SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textController: _passwordController, 
                          type: "password", 
                          enabled: isEnabled, 
                          obscureText: isHidden, 
                          showSuffix: true, 
                          onSuffixTap: (){
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                        ),
                        CustomTextField(
                          textController: _passwordConfirmController, 
                          type: "confirmPassword", 
                          enabled: isEnabled, 
                          obscureText: isConfirmHidden, 
                          showSuffix: true,
                          onSuffixTap: (){
                            setState(() {
                              isConfirmHidden = !isConfirmHidden;
                            });
                          },
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
                    onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if(_passwordController.text == _passwordConfirmController.text){
                        setState(() {
                          staticColorButton = Color.fromRGBO(31, 71, 104, 0.749);
                          buttonChild = SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator.adaptive(strokeWidth: 3),
                          );
                        });
                      }
                      else{
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(title: "Erro ao Alterar Senha", content: "As senhas não coincidem. Por favor, verifique as senhas e tente novamente",);
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
                      Navigator.pop(context);
                    },
                    child: Text("Voltar", style: TextStyle(color: Colors.white),) 
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