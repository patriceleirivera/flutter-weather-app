import 'package:flutter/material.dart';

class WeatherDataItem extends StatelessWidget {
  final String label;
  final String value;

  const WeatherDataItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
