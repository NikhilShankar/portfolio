import 'package:flutter/material.dart';

class HoverImageWidget extends StatefulWidget {
  final String? imageUrl;
  final String title;
  final String subtitle;

  const HoverImageWidget({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  State<HoverImageWidget> createState() => _HoverImageWidgetState();

}

class _HoverImageWidgetState extends State<HoverImageWidget> {
  bool isHoveredSection = false;
  bool isHoveredImage = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHoveredSection = true),
      onExit: (_) => setState(() => isHoveredSection = false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) {
              // Trigger hover effects (shadow and border) on mouse enter
            },
            onExit: (_) {
              // Revert hover effects on mouse exit
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isHoveredImage? Border.all(
                  color: Colors.black, // Border color
                  width: 2, // Border width
                ): Border.all(
                  color: Colors.white, // Border color
                  width: 2, // Border width
                ),
                boxShadow: [
                  BoxShadow(
                    color: isHoveredImage? Colors.black.withOpacity(0.3) : Colors.transparent, // Shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: widget.imageUrl != null? MouseRegion(
                onEnter: (_) => setState(() => isHoveredImage = true),
                onExit: (_) => setState(() => isHoveredImage = false),
                child: ClipOval(
                  child: Image.network(
                    widget.imageUrl!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ):null,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            widget.subtitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
