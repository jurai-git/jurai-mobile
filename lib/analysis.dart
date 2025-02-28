import 'package:flutter/material.dart';
import 'package:jurai/profile.dart';

int buttonIndex = 0;

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profile(),
                          ),
                        );
                      },
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
                child: SingleChoice(
                  onSelectionChanged: (value) {
                    setState(() {
                      buttonIndex = value - 1;
                    });
                  },
                ),
              ),
              if (buttonIndex == 0) RenderPdf(),
              if (buttonIndex == 1) RenderEment(),
            ],
          ),
        ),
      ),
    );
  }
}

enum Options { pdf, ementa }

class SingleChoice extends StatelessWidget {
  final Function(int) onSelectionChanged;
  const SingleChoice({super.key, required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Options>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        backgroundColor: Color.fromRGBO(120, 120, 128, 0.120),
        foregroundColor: Color(0x77808080),
        selectedForegroundColor: Colors.black,
        side: BorderSide(color: Colors.transparent, width: 0),
        textStyle: TextStyle(fontWeight: FontWeight.w400),
      ),
      segments: const <ButtonSegment<Options>>[
        ButtonSegment<Options>(value: Options.pdf, label: Text('PDF')),
        ButtonSegment<Options>(value: Options.ementa, label: Text('Ementa')),
      ],
      selected: <Options>{Options.values[buttonIndex]},
      onSelectionChanged: (Set<Options> newSelection) {
        Options selectedOption = newSelection.first;
        int selectedValue = selectedOption == Options.pdf ? 1 : 2;
        onSelectionChanged(selectedValue);
      },
    );
  }
}

class RenderPdf extends StatelessWidget {
  const RenderPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Selecione o arquivo PDF da sua demanda para realizar a análise  da mesma",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class RenderEment extends StatelessWidget {
  const RenderEment({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "Digite o texto da sua ementa para fazer a análise da mesma",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 600,
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0x772B2932),
            borderRadius: BorderRadius.circular(50),
          ),
          child: TextField(
            maxLines: null,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              hintText: "Digite aqui...",
              border: InputBorder.none,
            ),
          ),
          
        ),
        Container(
          margin: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
                Color(0xFF2B2932),
                Color(0xFF1E1E1E),
              ],
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateColor.transparent,
              fixedSize: WidgetStateProperty.all(Size.fromWidth(250)),
              padding: WidgetStateProperty.all(EdgeInsets.all(30)),
            ),
            child: Text("Analisar", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
