import 'dart:async';

import 'package:bird_game/models/bird_flying.dart';
import 'package:bird_game/models/bird_dead.dart';
import 'package:flutter/material.dart';

class MyTest extends StatefulWidget {
  const MyTest({Key? key, required int gameScore}) : super(key: key);

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  static double birdY = 0;
  double alpha = -35;

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (alpha <= 30) {
          alpha += 2;
        }
      });
    });
    return Scaffold(
      body: Container(
        child: Center(
          // child: BirdIdle(birdY:birdY, birdWidth: 0.2, birdHeight: 0.1),
          child: Stack(
            children: [
              BirdFlying(birdWidth: 0.2, birdHeight: 0.1 , alpha: alpha, birdY: birdY,),
            ],
          )
        ),
      ),
    );
  }
}
