import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/models/advogado.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/view/pages/profile.dart';

class Nav extends ConsumerStatefulWidget {
  final Advogado? advogado;

  const Nav({super.key, required this.advogado});

  @override
  ConsumerState<Nav> createState() => _NavState();
}

class _NavState extends ConsumerState<Nav> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 25, top: 50),
          child: Image.asset('img/jurai-name.png', scale: 6.5),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 25, top: 50),
          child: IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(advogado: widget.advogado),
                ),
              );
            }, 
            style: IconButton.styleFrom(
              shape: CircleBorder()
            ),
            icon: ClipOval(
              child: Image.network(
                "http://127.0.0.1:5000/advogado/${widget.advogado!.id.toString()}/pfp",
                width: 45, 
                height: 45, 
                fit: BoxFit.cover,
              ),
            )
          ),
        )
      ],
    );
  }
}