/*
 * @Description: 
 * @Author: FlutterCandies
 * @email: 
 * @Date: 2020-01-06 20:07:52
 * @LastEditTime: 2020-01-07 11:04:19
 * @LastEditors: leooooli
 * @LastEmail: gdutlikai@163.com
 */

import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  Paint _paint;
  final Color color;
  final RelativeRect position;
  final Size size;
  final double radius;
  final bool isInverted;
  final double screenWidth;

  TrianglePainter(
      {@required this.color,
      @required this.position,
      @required this.size,
      this.radius = 20,
      this.isInverted = false,
      this.screenWidth}) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..strokeWidth = 10
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width - this.size.width + this.size.width / 1.5,
        isInverted ? 0 : size.height);
    path.lineTo(
        size.width - this.size.width + this.size.width / 1.5 - radius / 3,
        isInverted ? size.height : 0);
    path.lineTo(
        size.width - this.size.width + this.size.width / 1.5 + radius / 3,
        isInverted ? size.height : 0);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
