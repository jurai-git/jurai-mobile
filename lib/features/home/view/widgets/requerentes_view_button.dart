import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/recent_acess_provider.dart';
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
            backgroundColor: Color.fromRGBO(30, 29, 34, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.5)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //shadowColor: const Color.fromRGBO(255, 255, 255, 0.1),
            elevation: 2.5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
                padding: widget.requerente.id_requerente != -1 ? EdgeInsets.all(10) : EdgeInsets.all(30),
                child: widget.requerente.id_requerente != -1 ? Center(child: Text(widget.requerente.nome.trim().split(' ').map((l) => l[0]).take(2).join(), style: TextStyle(color: Color(0xFF387FB9), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5),)) : null,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.requerente.nome == '' ? "placeholder" : widget.requerente.nome,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.requerente.email == '' ? "placeholder" : widget.requerente.email,
                        style: TextStyle(color: Colors.white60, fontSize: 17),
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
