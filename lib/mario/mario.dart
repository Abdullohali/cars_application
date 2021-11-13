import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final direction;
  final midrun;

  MyMario({this.direction, this.midrun});

  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: 60,
        height: 60,
        child: midrun
            ? Image.asset("assets/images2/standing.png")
            : Image.asset("assets/images2/running.png"),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: 60,
          height: 60,
          child: midrun
            ? Image.asset("assets/images2/standing.png")
            : Image.asset("assets/images2/running.png"),
        ),
      );
    }
  }
}
