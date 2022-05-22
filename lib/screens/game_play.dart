import 'dart:async';

import 'package:flappy_bird/models/bird.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  State<GamePlay> createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9; // how strong the gravity is
  double velocity = 3; // how strong the jump is

  // Game setting
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      // a real physical jump is the same as an upside down parabola
      // so this is a simple quadratic equation
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      if (birdY < -1.7 || birdY > 1.7) {
        timer.cancel();
      }

      // keep the time going
      time += 0.01;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [MyBird(birdY)],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                // image: Image.asset("assets/images/sprites/ground.png")
              ),
            )
          ],
        ),
      ),
    );
  }
}
