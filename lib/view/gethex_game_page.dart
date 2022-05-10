import 'package:flutter/material.dart';

import 'package:gethex/main.dart';

class GethexGamePage extends StatefulWidget {
  const GethexGamePage({Key? key}) : super(key: key);

  @override
  State<GethexGamePage> createState() => _GethexGamePageState();
}

class _GethexGamePageState extends State<GethexGamePage> {
  Color _colorState = Colors.yellow;
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
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Guess The Color Hex!")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screen.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screen.width * 0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: _colorState,
                ),
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
                )
              ],
            ),
          ),
          SizedBox(
            height: screen.height * 0.05,
          ),
          ElevatedButton(
            onPressed: () => resetGame(),
            child: const Text("Random Color"),
          ),
          SizedBox(
            height: screen.height * 0.1,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screen.width * 0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ColorInputCell(
                          colorTarget: _colorState.red,
                          baseColor: _redState,
                          callback: setRedState,
                          title: 'R',
                        ),
                        ColorInputCell(
                          colorTarget: _colorState.green,
                          baseColor: _greenState,
                          callback: setGreenState,
                          title: 'G',
                        ),
                        ColorInputCell(
                          colorTarget: _colorState.blue,
                          baseColor: _blueState,
                          callback: setBlueState,
                          title: 'B',
                        ),
                      ],
                    ),
                  ),
                  userGuess != null
                      ? Container(
                          color: userGuess,
                          height: 100,
                          width: 100,
                        )
                      : Container()
                ],
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
        return const Icon(Icons.arrow_downward);
      }
      if (intBaseColor > targetColor) {
        return const Icon(Icons.arrow_upward);
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
            onSaved: callback,
            decoration: const InputDecoration(counterText: ""),
            maxLength: 2,
          ),
          width: 20,
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

class WinScreen extends StatelessWidget {
  final void Function() resetCallback;
  final int score;
  final Color guessedColor;
  final Color correctColor;

  const WinScreen({
    Key? key,
    required this.resetCallback,
    required this.score,
    required this.correctColor,
    required this.guessedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "You won!",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Number of Trials: $score",
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
                Text("Correct color: ${correctColor.toString()}"),
                Text("Your guess: ${guessedColor.toString()}"),
                ElevatedButton(
                    onPressed: () {
                      resetCallback();
                      Navigator.pop(context);
                    },
                    child: const Text("Reset Game"))
              ]),
        ),
      ),
    );
  }
}
