import 'package:flutter/material.dart';

class GetReady extends StatelessWidget {
  bool started;

  GetReady({required this.started});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.5),
      child: Text(
        started ? '' : "T A P  T O  P L A Y",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
