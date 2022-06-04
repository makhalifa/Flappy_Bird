import 'package:flutter/material.dart';

class MyPipe extends StatelessWidget {
  final pipeWidth; // out of 2,where 2 is the width of the screen
  final pipeHeight; // proportion of the screen height
  final pipeX;
  final bool isThisBottomPipe;

  MyPipe(
      {this.pipeHeight,
      this.pipeWidth,
      required this.isThisBottomPipe,
      this.pipeX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(
          (2 * pipeX + pipeWidth) / (2 - pipeWidth), isThisBottomPipe ? 1 : -1),
      child: Container(
        
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.white,
      //     width: 1,
      //   ),
      // ),
      
        // color: Colors.green,
        child: Image.asset(
          isThisBottomPipe
              ? "assets/images/bottom_pipe.png"
              : "assets/images/top_pipe.png",
          width: MediaQuery.of(context).size.width * pipeWidth / 2,
          height: MediaQuery.of(context).size.height * 3 / 4 * pipeHeight / 2,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
