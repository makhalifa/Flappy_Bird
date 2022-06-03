import 'package:flutter/material.dart';
class starthome2 extends StatefulWidget {
  const starthome2({Key? key}) : super(key: key);

  @override
  State<starthome2> createState() => _starthome2State();
}

class _starthome2State extends State<starthome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Expanded(
            flex: 6,
            child: Container(
              child: Row(children: [
                Container(
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/flappybird.png"))),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/bird.png"))),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/score.png"))),
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/start.png"))),
                )
              ]),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/background.png"))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/background2.png"))),
            ),
          )
        ],)

    );
  }
}

