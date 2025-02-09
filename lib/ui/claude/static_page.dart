// main.dart
import 'package:flutter/material.dart';
import 'package:portfolio/ui/claude/dark_bg.dart';
import 'package:portfolio/ui/claude/star_bg.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nikhil Shankar Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Ubuntu'),
          displayMedium: TextStyle(fontFamily: 'Ubuntu'),
          displaySmall: TextStyle(fontFamily: 'Ubuntu'),
          headlineLarge: TextStyle(fontFamily: 'TitleFont'),
          headlineMedium: TextStyle(fontFamily: 'TitleFont'),
          headlineSmall: TextStyle(fontFamily: 'TitleFont'),
          titleLarge: TextStyle(fontFamily: 'TitleFont'),
          titleMedium: TextStyle(fontFamily: 'TitleFont'),
          titleSmall: TextStyle(fontFamily: 'TitleFont'),
          bodyLarge: TextStyle(fontFamily: 'Ubuntu'),
          bodyMedium: TextStyle(fontFamily: 'Ubuntu'),
          bodySmall: TextStyle(fontFamily: 'Ubuntu'),
        ),
        fontFamily: 'TitleFont',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [Colors.black, Colors.black])
        ),
        child: const Stack(
          children: [
            SingleChildScrollView(
            child: Column(
              children: [
                IntroSection(),
                ProjectsSection(),
                ContactSection(),
              ],
            ),
          ), CustomAppBar(),],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter), backgroundBlendMode: BlendMode.darken),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: GestureDetector(
              onTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/nikhilshankarcs/')),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  isHovered ? 'Nikhil Shankar C S' : 'NS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isHovered ? Colors.white : Colors.white60
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              NavBarItem(title: 'Projects', onTap: () {}),
              NavBarItem(title: 'Contact', onTap: () {}),
              NavBarItem(title: 'Repos', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}


class NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<NavBarItem> createState() => _CustomNavBarItemState();
}

class _CustomNavBarItemState extends State<NavBarItem> {

  bool isHovered = false;



  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: widget.onTap,
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: isHovered ? Colors.white : Colors.white60
          ),
          ),
        ),
      ),
    );
  }
}

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define a breakpoint for mobile screens (e.g., 600 pixels)
    const mobileBreakpoint = 600.0;

    // Calculate padding based on screen width
    final horizontalPadding = screenWidth > mobileBreakpoint
        ? screenWidth / 5 // 1/3rd of screen width for larger screens
        : 20; // Fixed padding for mobile screens
    return Container(
      child:  Stack(
        children: [Container(
          width: double.infinity, // 100% width
          height: 300, // 75% of the available height
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_main.png"),
              fit: BoxFit.cover,
            ),
          ),
        ), Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: horizontalPadding.toDouble()),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  backgroundBlendMode: BlendMode.darken
                ),
                child: Text(
                  "Hey I am Nikhil, Here I showcase things I've built and things I've been passionate about.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 64, color: Colors.white70),
                ),
              ),
            ],
          ),
        )],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define a breakpoint for mobile screens (e.g., 600 pixels)
    const mobileBreakpoint = 600.0;

    // Calculate padding based on screen width
    final horizontalPadding = screenWidth > mobileBreakpoint
        ? screenWidth / 5 // 1/3rd of screen width for larger screens
        : 20; // Fixed padding for mobile screens
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontalPadding.toDouble()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 0) {
                // Web layout
                return const Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ProjectCard(
                      title: 'Project 1',
                      description: 'Description for Project 1',
                      imageUrl: 'https://via.placeholder.com/300',
                      projectUrl: 'https://project1.com',
                    ),
                    ProjectCard(
                      title: 'Project 2',
                      description: 'Description for Project 2',
                      imageUrl: 'https://via.placeholder.com/300',
                      projectUrl: 'https://project2.com',
                    ),
                    ProjectCard(
                      title: 'Project 3',
                      description: 'Description for Project 3',
                      imageUrl: 'https://via.placeholder.com/300',
                      projectUrl: 'https://project3.com',
                    ),
                    // Add more ProjectCards as needed
                  ],
                );
              } else {
                // Mobile layout
                return const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ProjectCard(
                        title: 'Project 1',
                        description: 'Description for Project 1',
                        imageUrl: 'https://via.placeholder.com/300',
                        projectUrl: 'https://project1.com',
                      ),
                      SizedBox(width: 20),
                      ProjectCard(
                        title: 'Project 2',
                        description: 'Description for Project 2',
                        imageUrl: 'https://via.placeholder.com/300',
                        projectUrl: 'https://project2.com',
                      ),
                      SizedBox(width: 20),
                      ProjectCard(
                        title: 'Project 3',
                        description: 'Description for Project 3',
                        imageUrl: 'https://via.placeholder.com/300',
                        projectUrl: 'https://project3.com',
                      ),
                      // Add more ProjectCards as needed
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String projectUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.projectUrl,
  });

  @override
  State<ProjectCard> createState() => _CustomProjectCardState();
}

class _CustomProjectCardState extends State<ProjectCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(widget.projectUrl)),
      child: Stack(
        children: [
          Image.asset (
              "assets/bg_main.png",
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
          ),
          const SizedBox(height: 12),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 16),
          ),
          Positioned.fill(child:Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.black, Colors.transparent, Colors.black], begin: Alignment.centerLeft, end: Alignment.centerRight)
            ),
          )),
          // Title & Description (Text on top of gradient)
          Positioned.fill(child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text remains visible
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Text remains visible
                  ),
                ),
              ],
            ),
          ),
          )],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Contact',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              SocialLink(
                platform: 'LinkedIn',
                url: 'https://www.linkedin.com/in/nikhilshankarcs/',
                icon: Icons.link,
              ),
              SocialLink(
                platform: 'GitHub',
                url: 'https://github.com/yourusername',
                icon: Icons.code,
              ),
              SocialLink(
                platform: 'BitBucket',
                url: 'https://bitbucket.org/yourusername',
                icon: Icons.source,
              ),
              SocialLink(
                platform: 'Play Store',
                url: 'https://play.google.com/store/apps/developer?id=yourid',
                icon: Icons.android,
              ),
              SocialLink(
                platform: 'Website',
                url: 'https://yourwebsite.com',
                icon: Icons.language,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialLink extends StatelessWidget {
  final String platform;
  final String url;
  final IconData icon;

  const SocialLink({
    super.key,
    required this.platform,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(platform),
          ],
        ),
      ),
    );
  }
}