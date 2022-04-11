import 'package:flutter/material.dart';
import 'package:gethex/controller/hex_controller.dart';
import 'package:gethex/view/gethex_game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GethexGamePage(),
    );
  }
}

final hexController = HexController();
