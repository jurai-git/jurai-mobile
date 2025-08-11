import 'package:flutter/material.dart';
import 'package:jurai/features/home/view/pages/navigation.dart';

class QuickAcessButton extends StatelessWidget {
  final int botNavBarIndex;
  final String urlImage, primaryText, secondaryText;
  const QuickAcessButton({super.key, required this.botNavBarIndex, required this.urlImage, required this.primaryText, required this.secondaryText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CustomBotNavBar(customIndex: botNavBarIndex,)));
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white54), borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.transparent
      ),
      child: Row(
        children: [
          Image.asset(urlImage, width: 100,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(primaryText, style: TextStyle(color: Colors.white),),
                Text(secondaryText, style: TextStyle(color: Colors.white70),)
              ],
            )
          )
        ],
      )
    );
  }
}