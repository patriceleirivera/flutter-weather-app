import 'package:flutter/material.dart';

class ModalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 20);

    var controlPoint1 = Offset(size.width / 4, 0);
    var endPoint1 = Offset(size.width / 2.1, 30.0);
    path.quadraticBezierTo(
      controlPoint1.dx,
      controlPoint1.dy,
      endPoint1.dx,
      endPoint1.dy,
    );

    var controlPoint2 = Offset(size.width - (size.width / 3.25), 65);
    var endPoint2 = Offset(size.width, 40);
    path.quadraticBezierTo(
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint2.dx,
      endPoint2.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
