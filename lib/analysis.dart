import 'package:flutter/material.dart';
import 'package:jurai/profile.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 50, top: 50),
                    child: Image.asset('img/jurai-name.png', scale: 6.5),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 50, top: 50),
                    child: ElevatedButton(
                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.amber,
                      ),
                      child: Image.asset("img/profile.png"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                    child: Text(
                      "Consulta Rápida",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),

                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                width: MediaQuery.of(context).size.width,
              child:SingleChoice(),
              ),
            ]
          )
        )
      )
    );
  }
}

enum Options {pdf, ementa}

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Options options = Options.pdf;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Options>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(backgroundColor: Color.fromRGBO(120, 120, 128, 0.120), foregroundColor: Color(0x77808080),selectedForegroundColor: Colors.black, side: BorderSide(color: Colors.transparent, width: 0), textStyle: TextStyle(fontWeight: FontWeight.w400)),
      segments: const <ButtonSegment<Options>>[
        ButtonSegment<Options>(
          value: Options.pdf,
          label: Text('PDF'),
        ),
        ButtonSegment<Options>(
          value: Options.ementa,
          label: Text('Ementa'),
        ),
      ],
      selected: <Options>{options},
      onSelectionChanged: (Set<Options> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          options = newSelection.first;
        });
      },
    );
  }
}
