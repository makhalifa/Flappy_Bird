import 'package:flutter/material.dart';

class starthome extends StatefulWidget {
  const starthome({Key? key}) : super(key: key);

  @override
  State<starthome> createState() => _starthomeState();
}

class _starthomeState extends State<starthome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/background.png"))),
                width: double.infinity,
                child: Container(
                  child: Container(
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.only(left: 185, top: 7, bottom: 8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                scale: 1.2,
                                image: AssetImage("assets/images/score.png"))),
                      ),
                      margin: EdgeInsets.only(left: 2, top: 160),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              scale: 1.4,
                              alignment: Alignment.centerLeft,
                              image: AssetImage("assets/images/start.png"))),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            scale: 0.6,
                            alignment: Alignment.topCenter,
                            image: AssetImage("assets/images/bird.png"))),
                    margin: EdgeInsets.only(top: 120),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: AssetImage("assets/images/flappybird.png"),
                          fit: BoxFit.contain)),
                  margin: EdgeInsets.only(top: 160, right: 40, left: 40),
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/background2.png"))),
                width: double.infinity,
              ))
        ],
      ),


    );
  }
}
