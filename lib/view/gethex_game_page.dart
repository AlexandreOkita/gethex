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
  String userGuess = "";

  setRedState(String? v) => setState(() {
        _redState = v;
      });

  setGreenState(String? v) => setState(() {
        _greenState = v;
      });

  setBlueState(String? v) => setState(() {
        _blueState = v;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guess The Color Hex!")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            width: 400,
            color: _colorState,
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: (() => setState(() {
                  _colorState = hexController.getRandomColor();
                  print(_colorState);
                })),
            child: const Text("Random Color"),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 600.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              )),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Iterable.generate(userGuess.length).map((charPos) {
              if (charPos <= 6) {
                return StatusSquare(
                  isOk: hexController.colorToString(_colorState)[charPos] == userGuess[charPos],
                );
              }
              return const StatusSquare(
                isOk: false,
              );
            }).toList(),
          ),
          const SizedBox(
            height: 25,
          ),
          hexController.isStringEqualColor(userGuess, _colorState)
              ? const Text(
                  "Correct!",
                  style: TextStyle(color: Colors.green),
                )
              : const Text("Wrong",
                  style: TextStyle(
                    color: Colors.red,
                  ))
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

  Widget colorComparation(String baseColor, int targetColor) {
    try {
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
          child: TextField(
            onChanged: callback,
            decoration: const InputDecoration(counterText: ""),
            maxLength: 2,
          ),
          width: 20,
        ),
        const SizedBox(
          height: 8,
        ),
        colorComparation(baseColor ?? "00", colorTarget)
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
