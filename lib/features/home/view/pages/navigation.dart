import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/models/advogado.dart';
import 'package:jurai/features/home/providers/advogado_provider.dart';
import 'package:jurai/features/home/view/pages/analysis.dart';
import 'package:jurai/features/home/view/pages/clients.dart';
import 'package:jurai/features/home/view/pages/devs.dart';
import 'package:jurai/features/home/view/pages/documents.dart';
import 'package:jurai/features/home/view/pages/profile.dart';
import 'package:jurai/features/home/view/pages/userhome.dart';

class CustomBotNavBar extends ConsumerStatefulWidget {
  final int? customIndex;
  const CustomBotNavBar({super.key, this.customIndex});

  @override
  ConsumerState<CustomBotNavBar> createState() => CheckState();
}

class CheckState extends ConsumerState<CustomBotNavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.customIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(25, 24, 29, 1),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: [UserHome(), Clients(), Documents(), Analysis(), Profile(advogado: ref.watch(advogadoProvider))].elementAt(selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color.fromRGBO(25, 24, 29, 1),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF387FB9),
          selectedFontSize: 15,
          unselectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description, size: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 30),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
