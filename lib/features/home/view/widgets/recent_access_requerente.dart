import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/clients_information.dart';
import 'package:jurai/features/home/viewmodel/home_viewmodel.dart';

class RecentAccessRequerente extends ConsumerStatefulWidget {
  final Requerente requerente;

  const RecentAccessRequerente({super.key, required this.requerente});

  @override
  ConsumerState<RecentAccessRequerente> createState() => _RecentAccessRequerenteState();
}

class _RecentAccessRequerenteState extends ConsumerState<RecentAccessRequerente> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(requerenteProvider.notifier).setRequerente(widget.requerente);
        ref.watch(homeViewModelProvider.notifier).getAllDemandasFromRequerente(id_requerente: widget.requerente.id_requerente);
        Navigator.push(context, MaterialPageRoute(builder: (_) => ClientsInformation(requerente: widget.requerente)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(20, 40, 60, 0.25),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              padding: EdgeInsets.all(20),
              child: Text(widget.requerente.nome.trim().split(' ').map((l) => l[0]).take(2).join(), style: TextStyle(color: Color(0xFF387FB9), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),),
            ),
            Text(widget.requerente.nome.split(' ')[0], style: TextStyle(color: Colors.white,)),
            Text(widget.requerente.nome.split(' ')[1], style: TextStyle(color: Colors.white,)),
          ],
        )
      )
    );
  }
}