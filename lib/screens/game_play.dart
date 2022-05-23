import 'dart:async';

import 'package:flappy_bird/bird_animation/bird_flying.dart';
import 'package:flappy_bird/models/barrier.dart';
import 'package:flappy_bird/bird_animation/bird_idle.dart';
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
  double birdWidth = 0.2;
  double birdHeight = 0.2;

  // Game setting
  bool gameHasStarted = false;

  // barrier variables
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    // out of 2. where 2 is the entire height of the screen
    // [toHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // a real physical jump is the same as an upside down parabola
      // so this is a simple quadratic equation
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }

      // keep the time going
      time += 0.01;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      'Play Again',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    // check if the bird is hitting the top or the bottom of the screen
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    // hits barriers
    // check if the bird is hitting a barrier
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdHeight &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/sprites/background.png"),
            fit: BoxFit.fill,
          )),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Stack(
                      children: [
                        birdIsDead()
                            ? BirdIdle(
                                birdY: birdY,
                                birdWidth: birdWidth,
                                birdHeight: birdHeight,
                              )
                            : BirdFly(
                                birdY: birdY,
                                birdWidth: birdWidth,
                                birdHeight: birdHeight,
                              ),
                        Container(
                          alignment: const Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'T A P  T O  PLAY ',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),

                        // Top Barrier 0
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][0],
                          isThisBottomBarrier: false,
                        ),

                        // Bottom Barrier 0
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][1],
                          isThisBottomBarrier: true,
                        ),

                        // Top Barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][0],
                          isThisBottomBarrier: false,
                        ),

                        // Bottom Barrier 1
                        MyBarrier(
                          barrierX: barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][1],
                          isThisBottomBarrier: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    // color: Colors.brown,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/sprites/ground.png"),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
