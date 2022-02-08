import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSectionTitle(String txt) {
  return Text(
    txt,
    textAlign: TextAlign.start,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ),
  );
}
