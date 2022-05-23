import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class BirdFly extends StatefulWidget {
  final birdY;
  final double birdWidth;
  final double birdHeight;

  const BirdFly(
      {Key? key, this.birdY, required this.birdWidth, required this.birdHeight})
      : super(key: key);

  @override
  State<BirdFly> createState() => _BirdFlyState();
}

class _BirdFlyState extends State<BirdFly> {
  List<String> frames = [
    'assets/images/sprites/bird_1.png',
    'assets/images/sprites/bird_2.png',
    'assets/images/sprites/bird_3.png',
  ];

  int currentFrameIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, widget.birdY),
      child: TimerBuilder.periodic(const Duration(milliseconds: 150),
          builder: (context) {
        currentFrameIndex = (currentFrameIndex + 1) % frames.length;
        return Image.asset(
          frames[currentFrameIndex],
          width: MediaQuery.of(context).size.width * widget.birdWidth / 2,
          height: MediaQuery.of(context).size.height *
              3 /
              4 *
              widget.birdHeight /
              2,
        );
      }),
    );
  }
}
