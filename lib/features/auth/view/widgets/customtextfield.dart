import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final String type;
  final bool obscureText;
  final Function()? onSuffixTap;
  final bool showSuffix;

  const CustomTextField({
    super.key,
    required this.textController,
    required this.type,
    this.obscureText = false,
    this.onSuffixTap,
    this.showSuffix = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late String _hintText;
  late String _iconPath;
  late String? Function(String?) _validator;

  @override
  void initState() {
    super.initState();

    // Setup hint, icon, and validator based on type
    switch (widget.type) {
      case "username":
        _hintText = "Nome de Usuário";
        _iconPath = "img/profile.svg";
        _validator = (value) =>
            value == null || value.isEmpty ? "O campo nome é obrigatório!" : null;
        break;
      case "oab":
        _hintText = "Nº OAB";
        _iconPath = "img/oab.svg";
        _validator = (value) {
          if (value == null || value.isEmpty) return "O campo Nº OAB é obrigatório!";
          if (!RegExp(r"^\d+$").hasMatch(value)) return "O campo Nº OAB deve conter apenas números!";
          return null;
        };
        break;
      case "email":
        _hintText = "E-mail";
        _iconPath = "img/email.svg";
        _validator = (value) {
          if (value == null || value.isEmpty) return "O campo e-mail é obrigatório!";
          if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) return "Formato de e-mail inválido!";
          return null;
        };
        break;
      case "password":
        _hintText = "Senha";
        _iconPath = "img/password.svg";
        _validator = (value) =>
            value == null || value.isEmpty ? "O campo senha é obrigatório!" : null;
        break;
      case "confirmPassword":
        _hintText = "Confirmar Senha";
        _iconPath = "img/password.svg";
        _validator = (value) =>
            value == null || value.isEmpty ? "Confirme sua senha!" : null;
        break;
      default:
        _hintText = "Campo";
        _iconPath = "img/profile.svg";
        _validator = (value) => null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
        inputFormatters: widget.type == "oab" ? [
          LengthLimitingTextInputFormatter(6),
        ] : null,
        keyboardType: widget.type == "oab" ? TextInputType.number : TextInputType.text,
        controller: widget.textController,
        obscureText: widget.obscureText,
        validator: _validator,
        style: TextStyle(color: Colors.white),
        textAlignVertical: widget.showSuffix ? TextAlignVertical(y: -.5) : null,
        decoration: InputDecoration(
          hintText: _hintText,
          hintStyle: TextStyle(color: Colors.grey),
          errorStyle: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold),
          prefixIcon: SvgPicture.asset(_iconPath),
          prefixIconConstraints: BoxConstraints(maxWidth: 20, maxHeight: 20),
          border: InputBorder.none,
          fillColor: Colors.transparent,
          suffixIcon: widget.showSuffix
              ? IconButton(
                  icon: SvgPicture.asset(
                    widget.obscureText ? "img/invisiblePassword.svg" : "img/visiblePassword.svg",
                  ),
                  onPressed: widget.onSuffixTap,
                )
              : null,
        ),
      ),
    );
  }
}
