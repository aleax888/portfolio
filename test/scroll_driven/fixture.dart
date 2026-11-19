import 'package:flutter/material.dart';

Widget fixture(
  ScrollController controller,
  Widget effect, {
  double before = 400,
  double after = 600,
  double width = 300,
}) {
  return MaterialApp(
    home: Center(
      child: SizedBox(
        height: 200,
        width: width,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              SizedBox(height: before),
              effect,
              SizedBox(height: after),
            ],
          ),
        ),
      ),
    ),
  );
}
