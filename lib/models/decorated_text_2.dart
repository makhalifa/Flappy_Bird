import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText2 extends StatelessWidget {
  final String myText;
  final double myFontSize;

  // ignore: use_key_in_widget_constructors
  const MyText2({required this.myText, required this.myFontSize});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Text(
        // The text border
        myText.toString(),
        // style: GoogleFonts.arsenal(),
        style: TextStyle(
          // color: Colors.white,
          fontSize: myFontSize,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5
            ..color = Colors.black,
        ),
      ),
      Text(
        // the text inside
        myText.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: myFontSize,
          fontWeight: FontWeight.bold,
        ),
      )
    ]);
  }
}
