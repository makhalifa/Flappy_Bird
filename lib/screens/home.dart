import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flappy Bird test"),
      ),
      body: Column(
        children: [
          const Text("Hello flutter"),
          Image.asset("assets/images/example/splash_screen.jpeg")
        ],
      ),
    );
  }
}
