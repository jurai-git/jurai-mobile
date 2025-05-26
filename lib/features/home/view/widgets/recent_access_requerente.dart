import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jurai/features/home/models/requerente.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';
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
          onTap: (){
            ref.read(requerenteProvider.notifier).setRequerente(widget.requerente);
            ref.watch(homeViewModelProvider.notifier).getAllDemandasFromRequerente(id_requerente: widget.requerente.id_requerente);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CustomBotNavBar(customIndex: 1)));
          },
          child: Column(
            children: [
              Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              padding: EdgeInsets.all(65),
              child: SvgPicture.asset("img/profile.svg"),
            ),
            Text(widget.requerente.nome.split(' ')[0] + " " +  widget.requerente.nome.split(' ')[1], style: TextStyle(color: Colors.white, fontSize: 28,)),
            ],
          ),
    );
  }
}