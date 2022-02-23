import 'package:flutter/material.dart';
import 'package:the_movie_app/core/constants.dart';

transitionShadow({double altura = 400}) {
  return Container(
    height: altura,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [mainColor, Colors.transparent, Colors.transparent, mainColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: const [0.25, 1, 0, 0],
      ),
    ),
  );
}
