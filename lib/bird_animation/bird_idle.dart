import 'package:flutter/material.dart';

class BirdIdle extends StatelessWidget {

  final birdY;
  final double birdWidth;
  final double birdHeight;

  BirdIdle({this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        "assets/images/sprites/bird_1.png",
        width: MediaQuery.of(context).size.width * birdWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
      ),
    );
  }
}
