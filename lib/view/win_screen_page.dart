import 'package:flutter/material.dart';

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