import 'package:flutter/material.dart';

class ProfileOptionsButton extends StatefulWidget {
  final String text;
  final IconData preffixIcon;
  final bool quit;
  final bool isLast;
  final Widget destiny;

  const ProfileOptionsButton({
    super.key,
    required this.text,
    required this.preffixIcon,
    this.quit = false,
    this.isLast = false,
    required this.destiny
  });

  @override
  State<ProfileOptionsButton> createState() => _ProfileOptionsButtonState();
}

class _ProfileOptionsButtonState extends State<ProfileOptionsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: !widget.isLast ? BorderSide(color: const Color.fromRGBO(255, 255, 255, 0.5), width: 1) : BorderSide.none),
      ),
      child: ElevatedButton(
        onPressed: () {
          !widget.quit ? Navigator.push(context, MaterialPageRoute(builder: (context) => widget.destiny))
          :
                    Scaffold.of(context).showBottomSheet(
                      (context) => Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                            )
                          ),
                          Container(
                            width: double.infinity,
                            height: 200,
                            //color: Colors.transparent,
                            color: Color.fromRGBO(25, 24, 29, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Você tem certeza que deseja sair da conta?",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    backgroundColor: Colors.transparent);
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Color.fromRGBO(25, 24, 29, 1),
          padding: EdgeInsets.all(25),
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
