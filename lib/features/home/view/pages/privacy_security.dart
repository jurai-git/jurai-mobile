import 'package:flutter/material.dart';
import 'package:jurai/features/home/view/widgets/profile_options_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacySecurity extends StatefulWidget {
  const PrivacySecurity({super.key});

  @override
  State<PrivacySecurity> createState() => _PrivacySecurityState();
}

class _PrivacySecurityState extends State<PrivacySecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacidade e Segurança", style: TextStyle(color: Colors.white)), centerTitle: true, iconTheme: IconThemeData(color: Color(0xFF387FB9)), backgroundColor: Colors.transparent,),
      backgroundColor: Color.fromRGBO(25, 24, 29, 1),
      body: Center(
        child: Column(
          children: [
            ProfileOptionsButton(text: "Termos de Privacidade", preffixIcon: Icons.privacy_tip_outlined, destiny: Text("")),
            ProfileOptionsButton(text: "Alteração de Senha", preffixIcon: Icons.lock_outline, destiny: Text(""), outsideUrl: true,),
          ],
        ),
      ),
    );
  }
}
