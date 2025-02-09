// Some syntax-sugarring
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';

extension on OVertex {
  OVertex to(OVertex b, double t) => OVertex(
    x + (b.x - x) * t,
    y + (b.y - y) * t,
  );
}

extension on Color? {
  Color? to(Color? b, double t) => Color.lerp(this, b, t);
}

typedef C = Colors;

// Now the actual example


class BackgroundWidget extends StatefulWidget {
  final Widget child;

  const BackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  BackgroundWidgetState createState() => BackgroundWidgetState();
}

final meshRectDark = OMeshRect(
  width: 3,
  height: 4,
  fallbackColor: Colors.orange,
  backgroundColor: Colors.black,
  vertices: [
    (-0.06, 0.03).v.bezier(east: (0.01, 0.2).v, south: (-0.13, 0.34).v, ),    (0.59, 0.35).v.bezier(east: (0.94, 0.4).v, south: (0.66, 0.36).v, west: (0.37, 0.3).v, ),    (1.19, 0.3).v.bezier(west: (1.06, 0.36).v, ),  // Row 1
    (-0.03, 0.48).v.bezier(north: (-0.03, 0.33).v, ),    (0.58, 0.49).v.bezier(north: (0.6, 0.49).v, east: (0.99, 0.51).v, west: (0.35, 0.47).v, ),    (1.19, 0.35).v.bezier(west: (1.08, 0.51).v, ),  // Row 2
    (-0.06, 0.7).v.bezier(east: (0.09, 0.67).v, south: (-0.2, 0.74).v, ),    (0.66, 0.54).v.bezier(east: (0.87, 0.55).v, south: (0.67, 0.56).v, west: (0.55, 0.53).v, ),    (1.19, 0.76).v.bezier(north: (1.22, 0.69).v, south: (1.13, 0.75).v, west: (1.06, 0.75).v, ),  // Row 3
    (-0.0, 1.11).v.bezier(north: (-0.28, 0.79).v, east: (0.18, 1.06).v, ),    (0.53, 1.08).v.bezier(north: (0.56, 0.66).v, east: (0.74, 1.11).v, west: (0.41, 1.07).v, ),    (1.11, 1.11).v.bezier(north: (1.05, 0.61).v, west: (1.04, 1.09).v, ),  // Row 4
  ],
  colors: const [
    Color(0x0f0f0606),    Color(0x0f0f0606),    Color(0x0f0f0606),  // Row 1
    Color(0xffffb266),    Color(0xffffe7bf),    Color(0xff9b2f5f),  // Row 2
    Color(0xffe27e2d),    Color(0xffb11a43),    Color(0xff9b4f97),  // Row 3
    Color(0xff090002),    Color(0xff070206),    Color(0xff0f0012),  // Row 4
  ],
);

class BackgroundWidgetState extends State<BackgroundWidget> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this)
    ..duration = const Duration(seconds: 30)
    ..forward()
    ..addListener(() {
      if (controller.value == 1.0) {
        controller.animateTo(0, curve: Curves.easeInOutQuint);
      }
      if (controller.value == 0.0) {
        controller.animateTo(1, curve: Curves.easeInOutCubic);
      }
    });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xff090002), // Customize opacity
        ),
        SizedBox(
        height: 500,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final dt = controller.value;
            return OMeshGradient(
              tessellation: 12,
              size: Size.infinite,
              mesh: OMeshRect(
                width: 3,
                height: 4,
                // We have some different color spaces available
                colorSpace: OMeshColorSpace.lab,
                fallbackColor: C.transparent,
                vertices: [
                  (0.0, 0.3).v.to((0.0, 0.0).v, dt),
                  (0.5, 0.15).v.to((0.5, 0.1).v, dt * dt),
                  (1.0, -0.1).v.to((1.0, 0.3).v, dt * dt), //

                  (-0.05, 0.68).v.to((0.0, 0.45).v, dt),
                  (0.63, 0.3).v.to((0.48, 0.54).v, dt),
                  (1.0, 0.1).v.to((1.0, 0.6).v, dt), //

                  (-0.2, 0.92).v.to((0.0, 0.58).v, dt),
                  (0.32, 0.72).v.to((0.58, 0.69).v, dt * dt),
                  (1.0, 0.3).v.to((1.0, 0.8).v, dt), //

                  (0.0, 1.2).v.to((0.0, 0.86).v, dt),
                  (0.5, 0.88).v.to((0.5, 0.95).v, dt),
                  (1.0, 0.82).v.to((1.0, 1.0).v, dt), //
                ],
                colors: [
                  const Color(0xff090002), const Color(0xff090002), const Color(0xff090002), //

                  const Color(0x0f0f0606)
                      ?.withOpacity(0.8)
                      .to(const Color(0x0f0f0606), dt),
                  const Color(0xffffb266)
                      ?.withOpacity(0.8)
                      .to(const Color(0xff9b2f5f), dt),
                  const Color(0xffe27e2d)
                      ?.withOpacity(0.90)
                      .to(const Color(0xffb11a43), dt), //

                  const Color(0xffb11a43).to(const Color(0xff090002), dt),
                  const Color(0xff090002)
                      ?.withOpacity(0.98)
                      .to(const Color(0xff090002), dt),
                  const Color(0xff090002).to(const Color(0xff090002), dt), //

                  const Color(0xff090002), const Color(0xff090002), const Color(0xff090002), //
                ],
              ),
            );
          },
        ),
      ),

      widget.child
      ]
    );
  }
}