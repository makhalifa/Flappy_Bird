import 'package:flutter/material.dart';

class GetReady extends StatefulWidget {
  bool started;

  GetReady({Key? key, required this.started}) : super(key: key);

  @override
  State<GetReady> createState() => _GetReadyState();
}

class _GetReadyState extends State<GetReady> {
  // ignore: non_constant_identifier_names
  Widget ready_msg() {
    return Stack(
      children: [
        Container(
            alignment: const Alignment(-0.5, 0.18),
            child: Image.asset("assets/images/tap.png",
                width: 150, fit: BoxFit.fill)),
        Container(
            alignment: const Alignment(0, -0.5),
            child: Image.asset("assets/images/get_ready.png",
                width: 300, fit: BoxFit.fill))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: const Alignment(-0.5, 0.18),
        child: widget.started ? const Text('') : ready_msg());
  }
}
