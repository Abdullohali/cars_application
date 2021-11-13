import 'dart:async';

import 'button.dart';
import 'mario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1.1;
  double time = 0;
  double heigt = 0;
  double intialHeigt = marioY;
  String direction = "right";
  bool midrun = false;

  void preJump() {
    time = 0;
    intialHeigt = marioY;
  }

  void jump() {
    preJump();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      heigt = -4.9 * time * time + 5 * time;

      if (intialHeigt - heigt > 1) {
        marioY = 1;
      } else {
        setState(() {
          marioY = intialHeigt - heigt;
        });
      }
    });
  }

  void moveRigt() {
    direction = "right";
    midrun = !midrun;
    setState(() {
      marioX += 0.02;
    });
  }

  void moveLeft() {
    direction = "left";
    midrun = !midrun;
    setState(() {
      marioX -= 0.02;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blue,
              child: AnimatedContainer(
                alignment: Alignment(marioX, marioY),
                duration: Duration(milliseconds: 0),
                child: MyMario(
                  direction: direction,
                  midrun: midrun,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    function1: moveLeft,
                  ),
                  MyButton(
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                    function1: jump,
                  ),
                  MyButton(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    function1: moveRigt,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
