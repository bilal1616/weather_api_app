import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    String backgroundImage;
    if (hour >= 6 && hour < 18) {
      backgroundImage = 'assets/day.jpg';
    } else {
      backgroundImage = 'assets/night.jpg';
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
