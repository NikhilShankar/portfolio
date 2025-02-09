import 'package:flutter/material.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8, // Shadow elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        color: Colors.white, // Background color for the card
        child: const Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circle Image at the top
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/passport_nikhil.jpg'), // Local image
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 16), // Space between the image and text
      
              // Name of the person
              Text(
                'Nikhil Shankar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8), // Space between name and profession
      
              // Profession or title
              Text(
                'Software Developer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16), // Space between the profession and the bio
      
              // Short Bio or about text
              Text(
                'Experienced software developer with a passion for creating mobile applications and innovative solutions. Constantly learning new technologies and looking for opportunities to grow.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
