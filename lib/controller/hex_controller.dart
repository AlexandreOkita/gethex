import 'dart:math';

import 'package:flutter/material.dart';

class HexController {
  Color getRandomColor() {
    return Color(Random().nextInt(0xffffffff)).withAlpha(0xFF);
  }

  bool isStringEqualColor(String string, Color color) {
    string = "Color(0xff$string)";
    return string == color.toString();
  }

  String colorToString(Color color) {
    String ret = color.toString().split("Color(0xff")[1];
    print(color.toString().split("Color(0xff"));
    print(ret);
    return ret.substring(0, ret.length);
  }
}

void main() {
  final randomHex = Random().nextDouble() * 0xFFFFFF.toInt();
}
