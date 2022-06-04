import 'dart:async';

import 'package:bird_game/screens/home.dart';
import 'package:flutter/material.dart';
class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 5), ()=>Navigator.push(
      context,
       MaterialPageRoute(builder: (context)=>MyHome())));
 }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image(
                      image: const AssetImage('assets/images/39227-joystick.gif'),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text('made by pioneers', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25))
          ],
        ),
      ),
    );
  }
}
