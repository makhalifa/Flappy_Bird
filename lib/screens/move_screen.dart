import 'dart:async';

import 'package:bird_game/models/bird_flying.dart';
import 'package:bird_game/models/ground.dart';
import 'package:flutter/material.dart';

class MoveScreen extends StatefulWidget {
  const MoveScreen({Key? key}) : super(key: key);

  @override
  State<MoveScreen> createState() => _MoveScreenState();
}

class _MoveScreenState extends State<MoveScreen> {
  double pos = 0;
  bool isStart = false;
  static double birdY = 0;
  // List<double> groundX = [-1,1];
  List<double> groundX = [0, 5590];
  bool started = true;
  void move() {
    print("Moving...");
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
          groundX[0] -= 50;
          groundX[1] -= 50;
          if (groundX[0] <= -5590) {
            groundX[0] = 5590;
          }if (groundX[1] <= -5590) {
            groundX[1] = 5590;
          }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                color: Colors.transparent,
                child: Center(
                    child: Stack(
                  children: [
                    Positioned(
                        child: BirdFlying(
                            birdY: birdY, birdHeight: 0.1, birdWidth: 0.2)),
                    Container(
                        alignment: Alignment(0, 0.5),
                        child: IconButton(
                            onPressed: move, icon: Icon(Icons.move_up)))
                  ],
                )),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Center(
                child: Stack(
                  children: [
                    MyGround(groundX: groundX[0]),
                    MyGround(groundX: groundX[1])
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
