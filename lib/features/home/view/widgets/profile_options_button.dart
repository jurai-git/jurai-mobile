import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/providers/demanda_provider.dart';
import 'package:jurai/features/home/providers/requerente_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileOptionsButton extends ConsumerStatefulWidget {
  final String text;
  final IconData preffixIcon;
  final bool quit;
  final bool isLast;
  final Widget destiny;
  final bool outsideUrl;

  const ProfileOptionsButton({
    super.key,
    required this.text,
    required this.preffixIcon,
    this.quit = false,
    this.isLast = false,
    required this.destiny,
    this.outsideUrl = false
  });

  @override
  ConsumerState<ProfileOptionsButton> createState() => _ProfileOptionsButtonState();
}

class _ProfileOptionsButtonState extends ConsumerState<ProfileOptionsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: !widget.isLast ? BorderSide(color: const Color.fromRGBO(255, 255, 255, 0.5), width: 1) : BorderSide.none),
      ),
      child: ElevatedButton(
        onPressed: widget.outsideUrl ? _launchUrl : () {
          !widget.quit ? Navigator.push(context, MaterialPageRoute(builder: (context) => widget.destiny))
          :
          showModalBottomSheet<void>(
            constraints: BoxConstraints.expand(height: 200),
            context: context,
            builder: (BuildContext context){
            return Container(
              color: Color.fromRGBO(25, 24, 29, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox( 
                      //margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Você tem certeza que deseja sair da conta?",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              maxLines: 1,
                            ),
                          )
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(
                            context,
                          ).hideCurrentSnackBar();
                          ref.watch(advogadoProvider.notifier).clear();
                          ref.watch(demandaProvider.notifier).clear();
                          ref.watch(demandaListProvider.notifier).clear();
                          ref.watch(requerenteProvider.notifier).clear();
                          ref.watch(requerenteListProvider.notifier).clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.destiny,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width - 50,
                            50,
                          
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                        ),
                        child: Text("Sair", style: TextStyle(color: Color.fromRGBO(25, 24, 29, 1),),),
                      ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          },
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width - 50,
                            50,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                          ),
                          child: Text("Ficar", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    )
                  ]
                ),
              );          
            }
          ); 
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromRGBO(25, 24, 29, 1),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
          shape: LinearBorder(),
        ),
        child: Row(
          children: [
            Icon(widget.preffixIcon, color: widget.quit ? Colors.red : Colors.white, size: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.text,
                style: TextStyle(color: widget.quit ? Colors.red : Colors.white, fontSize: 18),
              ),
            ),
            Spacer(),
            Icon(Icons.navigate_next, color: widget.quit ? Colors.red : Colors.white, size: 30),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(Uri.parse("https://github.com/jurai-git/jurai-server/blob/main/app/main/controller/advogado_controller.py"))) {
    throw Exception('Could not launch https://github.com/jurai-git/jurai-server/blob/main/app/main/controller/advogado_controller.py');
  }
}