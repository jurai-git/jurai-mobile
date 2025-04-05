import 'package:flutter/cupertino.dart';

class GradientBg extends LinearGradient {

  const GradientBg({
    super.begin = const Alignment(0, 0),
    super.end = const Alignment(1, 1),
    super.transform = const GradientRotation(45),
    super.colors = const [
            Color.fromRGBO(25, 24, 29, 1),
            Color.fromRGBO(12, 58, 96, 1),
          ],
  });
}
