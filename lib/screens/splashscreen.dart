import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bird_game/screens/home.dart';
import 'package:flutter/material.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  final audioplayer = AudioCache();
  @override
  void initState() {
    super.initState();
    // audioplayer.play('sounds/welcome_xp.mp3');
    Timer(
        const Duration(seconds: 5),
        () => {
              audioplayer.play('sounds/welcome_xp.mp3'),
              audioplayer.play('sounds/adelshakal.mp3'),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHome()))
            });
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
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Image(
                      image: AssetImage('assets/images/39227-joystick.gif'),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Text('Made with                         ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15)),
            const Text('P I O N E E R S',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))
          ],
        ),
      ),
    );
  }
}
