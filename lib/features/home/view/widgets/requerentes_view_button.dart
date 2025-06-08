import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/recent_acess_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/clients_information.dart';
import 'package:jurai/features/home/viewmodel/home_viewmodel.dart';

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
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child:
        ElevatedButton(
          onPressed: () {
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ClientsInformation(requerente: widget.requerente)));
              widget.ref.watch(recentReqAcessListProvider.notifier).setRecentReqAcessList(widget.requerente);
              widget.ref.watch(homeViewModelProvider.notifier).getAllDemandasFromRequerente(id_requerente: widget.requerente.id_requerente);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:Color.fromRGBO(43, 41, 50, 50),
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
                padding: widget.requerente.id_requerente != -1 ? EdgeInsets.all(20) : EdgeInsets.all(30),
                child: widget.requerente.id_requerente != -1 ? SvgPicture.asset("img/profile.svg") : null,
              ),
              Flexible(
                child: FittedBox( 
                  child:Text(widget.requerente.nome == '' ? "placeholder" : widget.requerente.nome, style: TextStyle(color: Colors.white, fontSize: 25,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                )
              )
            ],
          ),
        ),
    );
  }
}
