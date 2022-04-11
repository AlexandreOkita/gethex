import 'package:flutter/material.dart';
import 'package:gethex/main.dart';

class GethexGamePage extends StatefulWidget {
  const GethexGamePage({Key? key}) : super(key: key);

  @override
  State<GethexGamePage> createState() => _GethexGamePageState();
}

class _GethexGamePageState extends State<GethexGamePage> {
  Color _colorState = Colors.yellow;
  String userGuess = "";

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
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: TextField(
              onChanged: (value) => setState(() {
                userGuess = value;
              }),
            ),
          ),
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
