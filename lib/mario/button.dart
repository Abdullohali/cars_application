import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function1;

  MyButton({this.child,this.function1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.brown[300],
          child: child,
        ),
      ),
    );
  }
}
