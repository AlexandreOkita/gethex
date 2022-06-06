import 'package:flutter/material.dart';
import 'package:gethex/controller/hex_controller.dart';
import 'package:gethex/view/gethex_game_page.dart';
import 'package:gethex/view/name_input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/nameinput",
      routes: {
        "/": (context) => const GethexGamePage(),
        "/nameinput": (context) => const NameInputPage(),
      },
    );
  }
}

final hexController = HexController();
