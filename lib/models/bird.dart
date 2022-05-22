import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  // const MyBird({ Key? key }) : super(key: key);
  final birdY;

  MyBird(this.birdY);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        "assets/images/sprites/bird1.png",
        width: 500,
      ),
    );
  }
}
