import 'dart:async';

import 'package:bird_game/models/bird_flying.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  double y = -0.4;
  bool isFlyingDown = true;

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(const Duration(milliseconds: 100),
        builder: (context) {
      if (y <= -0.4) isFlyingDown = true;
      else if (y >= -0.3) isFlyingDown = false;

      if(isFlyingDown) y += 0.01;
      else y -= 0.01;

      return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                              alignment: Alignment(-0.25, y),
                              child: Image.asset(
                                "assets/images/flappybird.png",
                                width: 250,
                                height: 100,
                              )),
                          BirdFlying(
                            birdY: y,
                            birdX: 0.75,
                            birdWidth: 0.2,
                            birdHeight: 0.1,
                            alpha: 0.0,
                          ),
                          GestureDetector(
                            onTap: () => print("Start Game"),
                            child: Container(
                              alignment: Alignment(-0.5, 0.5),
                              child: Image.asset("assets/images/start_btn.png",
                                  width: 110, fit: BoxFit.fill),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => print("Score"),
                            child: Container(
                              alignment: Alignment(0.5, 0.5),
                              child: Image.asset("assets/images/score_btn.png",
                                  width: 110, fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/ground.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
              ],
            )),
      );
    });
  }
}
