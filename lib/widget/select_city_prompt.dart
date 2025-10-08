import 'package:flutter/material.dart';

class SelectCityPrompt extends StatelessWidget {
  const SelectCityPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    double iconSize = 50;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sunny, size: iconSize, color: Colors.amber[400]),
            SizedBox(width: 5), // just additional space
            Icon(Icons.cloud_sharp, size: iconSize, color: Colors.lightBlue[100]),
            Icon(Icons.flash_on, size: iconSize, color: Colors.yellow[500]),
            Icon(Icons.ac_unit, size: iconSize, color: Colors.blue[100]),
          ],
        ),
        SizedBox(height: 10),
        const Text(
          "Select a city to check weather.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
