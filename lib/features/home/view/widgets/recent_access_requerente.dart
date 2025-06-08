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
    return Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color.fromARGB(255, 32, 31, 36),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              padding: EdgeInsets.all(50),
              child: SvgPicture.asset("img/profile.svg"),
            ),
            Text(widget.requerente.nome.split(' ')[0] + " " +  widget.requerente.nome.split(' ')[1], style: TextStyle(color: Colors.white, fontSize: 28,)),
            TextButton(
              onPressed: (){
                ref.read(requerenteProvider.notifier).setRequerente(widget.requerente);
                ref.watch(homeViewModelProvider.notifier).getAllDemandasFromRequerente(id_requerente: widget.requerente.id_requerente);
                Navigator.push(context, MaterialPageRoute(builder: (_) => ClientsInformation(requerente: widget.requerente)));
              }, 
              child: Text("Ver detalhes", style: TextStyle(color: Color(0xFF387FB9),),)
            )
          ],
        ),
    );
  }
}