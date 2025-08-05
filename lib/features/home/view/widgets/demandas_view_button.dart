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
            backgroundColor: Color.fromRGBO(30, 29, 34, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.5)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //shadowColor: const Color.fromRGBO(255, 255, 255, 0.1),
            elevation: 2.5,
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 20,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(20, 40, 60, 0.25),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                width: 50,
                height: 50,
                padding: widget.demanda.id != -1 ? EdgeInsets.all(10) : EdgeInsets.all(30),
                child: widget.demanda.id != -1 ? Center(child: Icon(Icons.description, color: Color(0xFF387FB9),)) : null,
              ),
              Flexible(
                child: FittedBox( 
                  child: Text(widget.demanda.id != -1 ? widget.demanda.identificacao : "placeholder", style: TextStyle(color: Colors.white, fontSize: 22), overflow: TextOverflow.ellipsis, maxLines: 1,),
                )
              )
            ],
          ),
      )
    );
  }
}
