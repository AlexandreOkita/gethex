import 'package:flutter/material.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({Key? key}) : super(key: key);

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  String? username;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        const Text(
          "Insert your name:",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 80,
        ),
        Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 36),
              maxLength: 25,
              onFieldSubmitted: (value) => setState(
                () {
                  username = value;
                  Navigator.pushNamed(context, '/');
                },
              ),
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    ));
  }
}
