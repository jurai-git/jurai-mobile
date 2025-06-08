import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/demanda.dart';
import 'package:jurai/features/home/view/pages/demandas_details.dart';

class DemandasViewButton extends StatefulWidget {
  final Demanda demanda;
  final WidgetRef ref;

  const DemandasViewButton({super.key, required this.demanda, required this.ref});

  @override
  State<DemandasViewButton> createState() => _DemandasViewButtonState();
}

class _DemandasViewButtonState extends State<DemandasViewButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child:
        ElevatedButton(
          onPressed: () {
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DemandasDetails(demanda: widget.demanda)));
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
                padding: widget.demanda.id != -1 ? EdgeInsets.all(20) : EdgeInsets.all(30),
                child: widget.demanda.id != -1 ? Icon(Icons.description, color: Colors.white,) : null,
              ),
              Flexible(
                child: FittedBox( 
                  child: Text(widget.demanda.id != -1 ? widget.demanda.identificacao : "placeholder", style: TextStyle(color: Colors.white, fontSize: 25), overflow: TextOverflow.ellipsis, maxLines: 1,),
                )
              )
            ],
          ),
      )
    );
  }
}
