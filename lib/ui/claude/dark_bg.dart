import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final Random _random = Random();
  List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    // Generate random particles (glowing dots)
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 4 + 2, // Particle size
        opacity: _random.nextDouble(),
        dx: (_random.nextDouble() - 0.5) * 0.002, // Slow drift in x-direction
        dy: (_random.nextDouble() - 0.5) * 0.002, // Slow drift in y-direction
      ));
    }

    _ticker = createTicker((_) {
      setState(() {
        for (var particle in _particles) {
          particle.update();
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
          colors: [Colors.black, Colors.blueGrey.shade900],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(
        painter: ParticlePainter(_particles),
        child: Container(),
      ),
    );
  }
}

class Particle {
  double x, y, size, opacity, dx, dy;

  Particle({required this.x, required this.y, required this.size, required this.opacity, required this.dx, required this.dy});

  void update() {
    x += dx;
    y += dy;

    // Bounce off the edges
    if (x < 0 || x > 1) dx = -dx;
    if (y < 0 || y > 1) dy = -dy;

    opacity += (Random().nextDouble() * 0.05 - 0.025);
    opacity = opacity.clamp(0.2, 1.0);
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    for (var particle in particles) {
      paint.color = Colors.white.withOpacity(particle.opacity);
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
