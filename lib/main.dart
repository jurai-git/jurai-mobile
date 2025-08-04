import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurai/features/auth/view/pages/homepage.dart';
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: "MPLUSRounded1c",
        visualDensity: VisualDensity.compact,
        extensions: const[
          SkeletonizerConfigData.dark(
            effect: ShimmerEffect(baseColor: Color.fromRGBO(31, 30, 36, 1), highlightColor: Color.fromRGBO(54, 51, 63, 0.808)),
            containersColor: Color.fromRGBO(47, 44, 54, 0.808)
          )
        ]
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}

