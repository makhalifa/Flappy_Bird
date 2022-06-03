import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class TestSound extends StatelessWidget {
  const TestSound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FlatButton(
            onPressed: () {
              final audioPlayer = AudioCache();
              audioPlayer.play('sounds/sfx_die.wav');
              print("Playing...");
            },
            child: Text(
              "P L A Y",
              style: TextStyle(
                fontSize: 30
              ),
            ),
          ),
        ),
      ),
    );
  }
}
