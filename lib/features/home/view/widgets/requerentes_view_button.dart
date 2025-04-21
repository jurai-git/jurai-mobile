import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';

class RequerentesViewButton extends StatefulWidget {
  final Requerente requerente;
  final WidgetRef ref;

  const RequerentesViewButton({super.key, required this.requerente, required this.ref});

  @override
  State<RequerentesViewButton> createState() => _RequerentesViewButtonState();
}

class _RequerentesViewButtonState extends State<RequerentesViewButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.ref.watch(requerenteProvider.notifier).setRequerente(widget.requerente);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(43, 41, 50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        shadowColor: const Color.fromRGBO(255, 255, 255, 0.1),
        elevation: 5,
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 20,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            padding: EdgeInsets.all(20),
            child: Image.asset("img/profile.png", scale: .7),
          ),

          Text(widget.requerente.nome, style: TextStyle(color: Colors.white, fontSize: 25)),
        ],
      ),
    );
  }
}
