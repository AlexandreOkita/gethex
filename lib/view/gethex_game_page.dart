import 'package:flutter/material.dart';

import 'package:gethex/main.dart';
import 'package:gethex/view/win_screen_page.dart';

class GethexGamePage extends StatefulWidget {
  const GethexGamePage({Key? key}) : super(key: key);

  @override
  State<GethexGamePage> createState() => _GethexGamePageState();
}

class _GethexGamePageState extends State<GethexGamePage> {
  Color _colorState = hexController.getRandomColor();
  String? _redState;
  String? _greenState;
  String? _blueState;
  Color? userGuess;
  int guessCounter = 0;
  final _formKey = GlobalKey<FormState>();

  setRedState(String? v) => setState(() {
        _redState = v;
      });

  setGreenState(String? v) => setState(() {
        _greenState = v;
      });

  setBlueState(String? v) => setState(() {
        _blueState = v;
      });

  resetGame() => setState(() {
        _formKey.currentState!.reset();
        guessCounter = 0;
        _redState = null;
        _greenState = null;
        _blueState = null;
        _colorState = hexController.getRandomColor();
        userGuess = null;
        print(_colorState);
      });

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments;
    print(name);
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screen.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ColorSquare(color: _colorState, text: "Guess the Color Hex!"),
                Column(
                  children: [
                    const Text(
                      "Trials",
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Text(guessCounter.toString(), style: const TextStyle(fontSize: 36)),
                  ],
                ),
                ColorSquare(color: userGuess ?? Colors.black, text: "Your Guess"),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screen.width * 0.2),
            ),
            SizedBox(
              height: screen.height * 0.1,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: screen.width * 0.3),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ColorInputCell(
                        colorTarget: _colorState.red,
                        baseColor: _redState,
                        callback: setRedState,
                        title: 'RED',
                      ),
                      ColorInputCell(
                        colorTarget: _colorState.green,
                        baseColor: _greenState,
                        callback: setGreenState,
                        title: 'GREEN',
                      ),
                      ColorInputCell(
                        colorTarget: _colorState.blue,
                        baseColor: _blueState,
                        callback: setBlueState,
                        title: 'BLUE',
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: screen.height * 0.1,
            ),
            ElevatedButton(
                onPressed: () {
                  try {
                    setState(() {
                      _formKey.currentState!.save();
                      userGuess = hexController.generateColor(
                        _redState ?? "00",
                        _greenState ?? "00",
                        _blueState ?? "00",
                      );
                      if (hexController.isColorCloseEnough(userGuess!, _colorState)) {
                        showDialog(
                            context: context,
                            builder: (context) => WinScreen(
                                  resetCallback: resetGame,
                                  score: guessCounter,
                                  correctColor: _colorState,
                                  guessedColor: userGuess!,
                                ));
                      }
                      guessCounter += 1;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Can't generate the color!")));
                  }
                },
                child: const Text("Guess!")),
          ],
        ),
      ),
    );
  }
}

class ColorInputCell extends StatelessWidget {
  final String? baseColor;
  final int colorTarget;
  final Function(String?) callback;
  final String title;
  const ColorInputCell(
      {Key? key,
      required this.baseColor,
      required this.colorTarget,
      required this.callback,
      required this.title})
      : super(key: key);

  Widget colorComparation(String? baseColor, int targetColor) {
    try {
      if (baseColor == null) {
        return Container();
      }
      final intBaseColor = int.parse(baseColor, radix: 16);
      if (intBaseColor < targetColor) {
        return const Icon(Icons.arrow_upward);
      }
      if (intBaseColor > targetColor) {
        return const Icon(Icons.arrow_downward);
      }
      return const Icon(Icons.check);
    } catch (e) {
      return const Icon(Icons.clear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          child: TextFormField(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
            ),
            onSaved: callback,
            decoration: const InputDecoration(counterText: ""),
            maxLength: 2,
          ),
          width: 60,
        ),
        const SizedBox(
          height: 8,
        ),
        colorComparation(baseColor, colorTarget)
      ],
    );
  }
}

class StatusSquare extends StatelessWidget {
  final bool isOk;

  const StatusSquare({Key? key, required this.isOk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 10,
        width: 10,
        color: isOk ? Colors.green : Colors.red,
      ),
    );
  }
}

class ColorSquare extends StatelessWidget {
  final Color color;
  final String text;

  const ColorSquare({required this.color, Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: 300,
          color: color,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
