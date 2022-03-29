// Example which demonstrates a possible way of implementing inner shadows in Flutter
// Preview: https://i.ibb.co/q0Xn4s3/Image.png

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Decided to declare child here, so it less distract you :)
  final Widget child = Padding(
    padding: EdgeInsets.all(25),
    child: Text(
      'Yoooo!',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: HSLColor.fromAHSL(0.3, 220, 0.3, 0.3).toColor(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HSLColor.fromAHSL(1, 220, 0.2, 0.93).toColor(),
      child: Center(child: InnerShadowBox(child: child)),
    );
  }
}

class InnerShadowBox extends StatelessWidget {
  final Widget child;
  const InnerShadowBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // `Clip.hardEdge` helps to clip shadow from second container,
      // so it looks like inner shadow
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: HSLColor.fromAHSL(1, 220, 0.2, 0.93).toColor(),
        borderRadius: BorderRadius.circular(15),
        // Thats regular drop shadow, don't make attention to it,
        // continue to the child :)
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            color: HSLColor.fromAHSL(0.2, 220, 1, 0.2).toColor(),
            offset: Offset(7, 7),
          ),
          BoxShadow(
            blurRadius: 14,
            color: Colors.white,
            offset: Offset(-7, -7),
          ),
        ],
      ),
      // SOO, I am suggesting to use inner container, which can
      // create inner shadow effect.
      child: Container(
        // Child is gonnna be placed inside second container.
        child: child,
        decoration: BoxDecoration(
          // This container projects his own box shadow, which
          // gets clipped by parent container, so it looks like inner shadow.
          boxShadow: [
            // This one projects white shadow with opacity
            BoxShadow(
              blurRadius: 7,
              color: HSLColor.fromAHSL(0.5, 0, 0, 1).toColor(),
              offset: Offset(14, 14),
            ),
            // Second shadow is darker, so it compensates light (first) shadow,
            // and makes it look like a background. Plus, place, where
            // light (first) shadow could'nt reach (top and left sides
            // (cause of `Offset(14,14)`)), is darker, cause of this shadow.
            BoxShadow(
              blurRadius: 7,
              color: HSLColor.fromAHSL(0.5, 220, 0.2, 0.9).toColor(),
              offset: Offset(-14, -14),
            ),
          ],
          // I hope you got me. Have a great day! :)
        ),
      ),
    );
  }
}
