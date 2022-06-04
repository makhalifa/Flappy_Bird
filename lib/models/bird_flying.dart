import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class BirdFlying extends StatefulWidget {
  final birdY;
  final alpha;
  final double birdWidth;
  final double birdHeight;
  final birdX;

  const BirdFlying(
      {this.birdY,
      this.birdX = 0.0,
      required this.birdWidth,
      required this.birdHeight,
      this.alpha});

  @override
  State<BirdFlying> createState() => _BirdFlyingState();
}

class _BirdFlyingState extends State<BirdFlying> {
  // Images the will change between them over time
  List<String> frames = [
    'assets/images/bird_1.png',
    'assets/images/bird_2.png',
    'assets/images/bird_3.png',
  ];

  int currentFrameIndex = 0;

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(const Duration(milliseconds: 300),
        builder: (context) {
      currentFrameIndex = (currentFrameIndex + 1) % frames.length;

      return Container(
        alignment: Alignment(widget.birdX, widget.birdY),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(widget.alpha / 360),
          child: Image.asset(
            frames[currentFrameIndex],
            width: MediaQuery.of(context).size.width * widget.birdWidth / 2,
            height: MediaQuery.of(context).size.height *
                3 /
                4 *
                widget.birdHeight /
                2,
            fit: BoxFit.fill,
          ),
        ),
      );
    });
  }
}
