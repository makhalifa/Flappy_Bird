import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class MyDeadBird extends StatelessWidget {
  double birdY;
  final double birdWidth;
  final double birdHeight;

  // ignore: use_key_in_widget_constructors
  MyDeadBird(
      {required this.birdY, required this.birdWidth, required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(const Duration(milliseconds: 10),
        builder: (context) {
      if (birdY < 1) {
        birdY += 0.04;
      }
      // Newton's law of free fall for a bird
      // v = g * t
      // v = 9.8 * t

      return Container(
        alignment: Alignment(0, birdY),
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(90 / 360),
          child: Image.asset(
            "assets/images/bird_1.png",
            width: MediaQuery.of(context).size.width * birdWidth / 2,
            height: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
            fit: BoxFit.fill,
          ),
        ),
      );
    });
  }
}
