import 'package:flutter/material.dart';

class MyGround extends StatelessWidget {
  final double groundX;
  MyGround({required this.groundX});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(groundX + 1, -1),
      child: Image.asset(
        "assets/images/ground.png",
        // width: MediaQuery.of(context).size.width,
        scale: 0.81,
      ),
    );
  }
}
