import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';

class DemandasViewButton extends StatefulWidget {
  final Demanda demanda;
  final WidgetRef ref;
  final int count;

  const DemandasViewButton({super.key, required this.demanda, required this.ref, required this.count});

  @override
  State<DemandasViewButton> createState() => _DemandasViewButtonState();
}

class _DemandasViewButtonState extends State<DemandasViewButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.ref.watch(demandaProvider.notifier).setDemanda(widget.demanda);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(43, 41, 50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shadowColor: const Color.fromRGBO(255, 255, 255, 0.1),
        elevation: 5,
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 20,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            padding: EdgeInsets.all(20),
            child: Icon(Icons.description, color: Colors.white,),
          ),
          Flexible(
            child: FittedBox( 
              child: Text("Demanda ${widget.count}", style: TextStyle(color: Colors.white, fontSize: 25), overflow: TextOverflow.ellipsis, maxLines: 1,),
            )
          )
        ],
      ),
    );
  }
}
