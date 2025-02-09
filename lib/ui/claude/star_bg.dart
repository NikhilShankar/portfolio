import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class StarryBackground extends StatefulWidget {
  const StarryBackground({super.key});

  @override
  _StarryBackgroundState createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final Random _random = Random();
  List<Star> _stars = [];

  @override
  void initState() {
    super.initState();

    // Generate stars randomly across the screen
    for (int i = 0; i < 100; i++) {
      _stars.add(Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 2 + 1,
        opacity: _random.nextDouble(),
      ));
    }

    _ticker = createTicker((_) {
      setState(() {
        for (var star in _stars) {
          star.opacity = (star.opacity + (_random.nextDouble() * 0.05 - 0.025)).clamp(0.2, 1.0);
        }
      });
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.blue.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(
        painter: StarPainter(_stars),
        child: Container(),
      ),
    );
  }
}

class Star {
  double x, y, size, opacity;

  Star({required this.x, required this.y, required this.size, required this.opacity});
}

class StarPainter extends CustomPainter {
  final List<Star> stars;

  StarPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    for (var star in stars) {
      paint.color = Colors.white.withOpacity(star.opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}