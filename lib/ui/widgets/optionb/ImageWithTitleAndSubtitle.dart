import 'package:flutter/material.dart';

class ImageWithTitleAndSubtitle extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const ImageWithTitleAndSubtitle({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Checking the screen width to determine if it's mobile
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Set minimum width to prevent too small layout on mobile
        double minWidth = isMobile ? 200 : 300; // Minimum width for mobile

        return Column(
            children: [
              Container(
                width: double.infinity, // 100% width
                height: 300, // 75% of the available height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black45, // Optional background for readability
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
      },
    );
  }
}
