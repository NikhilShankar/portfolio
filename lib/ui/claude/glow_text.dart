import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GlowingText extends StatefulWidget {
  final String text;
  final double glowRadius;
  final Color glowColor;
  final TextStyle textStyle;
  final double glowIntensity;
  final double affectedRadius;

  const GlowingText({
    super.key,
    required this.text,
    this.glowRadius = 20,
    this.glowColor = Colors.blue,
    this.textStyle = const TextStyle(fontSize: 24, color: Colors.black),
    this.glowIntensity = 0.5,
    this.affectedRadius = 50,
  });

  @override
  State<GlowingText> createState() => _GlowingTextState();
}

class _GlowingTextState extends State<GlowingText> {
  Offset? mousePosition;
  final GlobalKey _textKey = GlobalKey();
  List<TextPosition>? _characterPositions;
  Size? _textSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateCharacterPositions();
    });
  }

  void _calculateCharacterPositions() {
    final RenderBox? box = _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    textPainter.layout();
    _textSize = textPainter.size;

    _characterPositions = List.generate(widget.text.length, (index) {
      final offset = textPainter.getOffsetForCaret(
        TextPosition(offset: index),
        ui.Rect.zero,
      );
      return TextPosition(offset: index, affinity: TextAffinity.upstream);
    });
  }

  double _calculateGlowIntensity(Offset charPosition) {
    if (mousePosition == null || _textSize == null) return 0;

    final distance = (charPosition - mousePosition!).distance;
    if (distance > widget.affectedRadius) return 0;

    return (1 - (distance / widget.affectedRadius)) * widget.glowIntensity;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        final RenderBox? box = _textKey.currentContext?.findRenderObject() as RenderBox?;
        if (box == null) return;

        setState(() {
          mousePosition = box.globalToLocal(event.position);
        });
      },
      onExit: (event) {
        setState(() {
          mousePosition = null;
        });
      },
      child: CustomPaint(
        painter: _GlowingTextPainter(
          text: widget.text,
          textStyle: widget.textStyle,
          glowRadius: widget.glowRadius,
          glowColor: widget.glowColor,
          mousePosition: mousePosition,
          characterPositions: _characterPositions,
          textSize: _textSize,
          calculateGlowIntensity: _calculateGlowIntensity,
        ),
        child: RepaintBoundary(
          child: Text(
            widget.text,
            key: _textKey,
            style: widget.textStyle,
          ),
        ),
      ),
    );
  }
}

class _GlowingTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final double glowRadius;
  final Color glowColor;
  final Offset? mousePosition;
  final List<TextPosition>? characterPositions;
  final Size? textSize;
  final double Function(Offset charPosition) calculateGlowIntensity;

  _GlowingTextPainter({
    required this.text,
    required this.textStyle,
    required this.glowRadius,
    required this.glowColor,
    required this.mousePosition,
    required this.characterPositions,
    required this.textSize,
    required this.calculateGlowIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (mousePosition == null || characterPositions == null || textSize == null) return;

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    for (var i = 0; i < text.length; i++) {
      final charOffset = textPainter.getOffsetForCaret(
        TextPosition(offset: i),
        ui.Rect.zero,
      );

      final intensity = calculateGlowIntensity(charOffset);
      if (intensity <= 0) continue;

      final charPainter = TextPainter(
        text: TextSpan(
          text: text[i],
          style: textStyle.copyWith(
            foreground: Paint()
              ..color = glowColor
              ..maskFilter = MaskFilter.blur(
                BlurStyle.outer,
                glowRadius * intensity,
              ),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      charPainter.layout();
      charPainter.paint(canvas, charOffset);
    }
  }

  @override
  bool shouldRepaint(covariant _GlowingTextPainter oldDelegate) {
    return mousePosition != oldDelegate.mousePosition;
  }
}
