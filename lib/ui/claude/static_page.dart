// main.dart
import 'package:flutter/material.dart';
import 'package:portfolio/ui/claude/dark_bg.dart';
import 'package:portfolio/ui/claude/star_bg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';


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
                ExperienceSection(),
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
                  color: Colors.white60,
                  backgroundBlendMode: BlendMode.darken
                ),
                child: Text(
                  "I'm Nikhil",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 48, color: Colors.white60),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.darken
                ),
                child: Text(
                  "Senior Software Developer",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 32, color: Colors.white),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.darken
                ),
                child: Text(
                  "Android | Backend | iOS",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 28, color: Colors.white),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white38,
                    backgroundBlendMode: BlendMode.darken
                ),
                child: Text(
                  "AI Enthusiast & Founder @NixacLabs",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24, color: Colors.white38),
                ),
              )
            ],
          ),
        )],
      ),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
            'Experience',
            style: TextStyle(
              color: Colors.white10,
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
                    ProjectCardAnimated(
                      title: 'Slice',
                      description: 'Fintech Startup Unicorn\nBangalore, India\nSoftware Development Engineer - 3, Android ',
                      imageUrl: 'assets/fintech_slice.jpg',
                      projectUrl: 'https://project1.com',
                      years: "2020 Oct - 2024 March",
                    ),
                    ProjectCardAnimated(
                      title: 'GreedyGame',
                      description: 'Adtech Startup\nBangalore, India\nFullstack Developer, Android, iOS, Backend',
                      imageUrl: 'assets/adtech_greedygame.png',
                      projectUrl: 'https://project2.com',
                      years: "2015 Sep - 2019 Oct",
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white70,
                backgroundBlendMode: BlendMode.darken
            ),
            child: Text(
              "CREATE\niTERATE\niNNOVATE",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 72, color: Colors.white70),
            ),
          ),
          const Text(
            'Projects',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const ProjectCardAnimated(
            title: 'NixacLabs',
            description: 'Apps for Utility & Entertainment',
            imageUrl: 'assets/nixac_labs.png',
            projectUrl: 'https://project3.com',
            years: "2019 Oct - 2020 Oct",
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 0) {
                // Web layout
                return const Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ProjectCardAnimated(
                      title: 'FanFightClub',
                      description: 'A code base which can generate multiple apps\nfrom a single code base',
                      imageUrl: 'assets/fanfightclub.png',
                      projectUrl: 'https://project1.com',
                      years: "",
                    ),
                    ProjectCardAnimated(
                      title: 'MMDB - MyMovieDatabase',
                      description: 'An android app to rate, review and create movie playlists',
                      imageUrl: 'assets/mmdb.jpg',
                      projectUrl: 'https://project2.com',
                      years: "",
                    ),
                    ProjectCardAnimated(
                      title: 'AIngel',
                      description: 'LLM based relationship building app.\nThat mutual friend we all wished for.\nCurrently part of Conestoga Venture Tech Lab - CEC Collective',
                      imageUrl: 'assets/aingel.jpg',
                      projectUrl: 'https://project3.com',
                      years: "2024 Oct - Present",
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


class ProjectCardAnimated extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String projectUrl;
  final String years;

  const ProjectCardAnimated({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.projectUrl,
    required this.years
  });

  @override
  State<ProjectCardAnimated> createState() => _ProjectCardAnimatedState();
}

class _ProjectCardAnimatedState extends State<ProjectCardAnimated> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationToTop;
  late Animation<double> _fadeAnimation;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Start off-screen left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimationToTop = Tween<Offset>(
      begin: const Offset(0, 5), // Start off-screen left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !isVisible) {
      isVisible = true;
      _controller.forward(); // Animate in
    } else if (info.visibleFraction == 0) {
      isVisible = false;
      _controller.reset(); // Reset animation when out of view
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: VisibilityDetector(
        key: Key(widget.title),
        onVisibilityChanged: _onVisibilityChanged,
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(widget.projectUrl)),
          child: Stack(
            children: [
              Image.asset(
                widget.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.black54, Colors.black],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _slideAnimationToTop,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            widget.years,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.5, 0), // Start off-screen right
                          end: Offset.zero,
                        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: isHovered ? Colors.white : Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

