import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:jurai/features/home/view/pages/profile.dart';

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
                      child: SvgPicture.asset("img/profile.svg"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                    child: Row(
                      children: [
                        Text(
                          "Consulta ",
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                        Text(
                          "Rápida",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

class RenderPdf extends StatefulWidget {
  const RenderPdf({super.key});

  @override
  _RenderPdfState createState() => _RenderPdfState();
}

class _RenderPdfState extends State<RenderPdf> {
  File? _file;
  Uint8List? _fileBytes;
  Text _fileName = Text("Clique aqui para fazer o upload do documento", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.250), fontSize: 16), textAlign: TextAlign.center);
  Icon uploadIcon = Icon(Icons.upload, size: 70, color: Color.fromRGBO(255, 255, 255, 0.250));
  ButtonStyle btnStyle = ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.transparent), shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))), shadowColor: WidgetStatePropertyAll(Colors.transparent));
  late ElevatedButton uploadButton;

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
        Container(
          height: MediaQuery.of(context).size.height - 600,
          margin: EdgeInsets.symmetric(horizontal: 40),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0x772B2932),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ElevatedButton(
            style: btnStyle,
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                setState(() {
                  _fileName = Text(result.files.single.name, style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,);
                  uploadIcon = Icon(Icons.document_scanner, size: 60, color: Colors.white);
                });
                if (kIsWeb) {
                  setState(() {
                    _fileBytes =
                        result
                            .files
                            .single
                            .bytes;
                  });
                } else {
                  setState(() {
                    _file = File(result.files.single.path!);
                  });
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _fileName
                  ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: uploadIcon,
                  ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 200,
          margin: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 29, 28, 34),
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (_file == null && _fileBytes == null) return;

              var request = http.MultipartRequest(
                'POST',
                Uri.parse('YOUR_API_ENDPOINT'),
              );

              if (_file != null) {
                request.files.add(
                  await http.MultipartFile.fromPath('file', _file!.path),
                );
              } else if (_fileBytes != null) {
                request.files.add(
                  http.MultipartFile.fromBytes(
                    'file',
                    _fileBytes!,
                    //filename: _fileName ?? 'uploaded_file',
                  ),
                );
              }

              var response = await request.send();

              if (response.statusCode == 200) {
                print('File uploaded successfully');
              } else {
                print('File upload failed');
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              fixedSize: Size.fromWidth(250),
              padding: EdgeInsets.all(25),
            ),
            child: Text("Analisar", style: TextStyle(color: Colors.white, fontSize: 16)),
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
          width: MediaQuery.of(context).size.width - 200,
          margin: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 29, 28, 34),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              fixedSize: Size.fromWidth(250),
              padding: EdgeInsets.all(25),
            ),
            child: Text("Analisar", style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
