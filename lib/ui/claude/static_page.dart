// main.dart
import 'package:flutter/material.dart';
import 'package:portfolio/ui/claude/content.dart';
import 'package:portfolio/ui/claude/dark_bg.dart';
import 'package:portfolio/ui/claude/project_animated_card_expandable.dart';
import 'package:portfolio/ui/claude/star_bg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Detect web environment



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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  final ScrollController _scrollController = ScrollController();

  // Global keys for identifying sections
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey appsKey = GlobalKey();
  final GlobalKey aimlKey = GlobalKey();

  HomePage({super.key});

  void _scrollToSection(GlobalKey sectionKey) {
    final context = sectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [Colors.black, Colors.black])
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
            child: Column(
              children: [
                IntroSection(),
                ExperienceSection(key: experienceKey),
                ProjectsSection(key: appsKey),
                ProjectsSection2(key: aimlKey)
              ],
            ),
          ), CustomAppBar(scrollToSection: _scrollToSection,experienceKey: experienceKey,
            appsKey: appsKey, aimlKey: aimlKey),Container(alignment: Alignment.bottomLeft, child:const ExpandableSocialLinks())],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {

  final Function(GlobalKey) scrollToSection;  // ✅ Accept scroll function
  final GlobalKey experienceKey;
  final GlobalKey appsKey;
  final GlobalKey aimlKey;

  const CustomAppBar({
    super.key,
    required this.scrollToSection,
    required this.experienceKey,
    required this.appsKey,
    required this.aimlKey,
  });

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
              NavBarItem(title: 'Experience', onTap: () {
                widget.scrollToSection(widget.experienceKey);
              }),
              NavBarItem(title: 'Apps', onTap: () {
                widget.scrollToSection(widget.appsKey);
              }),
              NavBarItem(title: 'AI/ML', onTap: () {
                widget.scrollToSection(widget.aimlKey);
              }),
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

  const ExperienceSection({Key? key}): super(key:key);

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
                // Web layout
                return const Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ProjectCardExpandable(
                      title: 'Slice',
                      description: 'Fintech Startup Unicorn\nBangalore, India\nSoftware Development Engineer - 3, Android ',
                      imageUrl: 'assets/fintech_slice.png',
                      projectUrl: 'https://www.sliceit.com/',
                      years: "2020 Oct - 2024 March",
                      subtitle: sliceDetails,
                      ctaText: "Visit Website",
                    ),
                    ProjectCardExpandable(
                      title: 'GreedyGame',
                      description: 'Adtech Startup\nBangalore, India\nFullstack Developer, Android, iOS, Backend',
                      imageUrl: 'assets/adtech_greedygame.png',
                      projectUrl: 'https://greedygame.com/',
                      years: "2015 Sep - 2019 Oct",
                      subtitle: greedyGameDetails,
                      ctaText: "Visit Website",
                    ),
                    // Add more ProjectCards as needed
                  ],
                );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  
  const ProjectsSection({Key? key}): super(key:key);

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
          const ProjectCardExpandable(
            title: 'NixacLabs',
            description: 'Apps for Utility & Entertainment',
            imageUrl: 'assets/nixac_labs.png',
            projectUrl: 'https://project3.com',
            years: "2019 Oct - Present",
            subtitle: nixacLabsDetails,
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
                // Web layout
                return const Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    ProjectCardAnimated(
                      title: 'FanFightClub',
                      description: 'A code base which can generate multiple apps\nfrom a single code base',
                      imageUrl: 'assets/fanfightclub.png',
                      projectUrl: 'https://bitbucket.org/nixacfilms/fanfightclub-android/src/master/',
                      years: "2019 Aug - 2024 Aug",
                    ),
                    ProjectCardAnimated(
                      title: 'MMDB - MyMovieDatabase',
                      description: 'An android app to rate, review and create movie playlists',
                      imageUrl: 'assets/mmdb.png',
                      projectUrl: 'https://bitbucket.org/nixacfilms/moviebuf/src/master/',
                      years: "",
                    ),
                    ProjectCardAnimated(
                      title: 'URL Manager',
                      description: 'An android app to create shortened URLs and maintain them.',
                      imageUrl: 'assets/url_shortener.png',
                      projectUrl: 'https://bitbucket.org/nixacfilms/url_manager/src/master/',
                      years: "",
                    ),
                    // Add more ProjectCards as needed
                  ],
                );
              }
          ),
        ],
      ),
    );
  }
}

class ProjectsSection2 extends StatelessWidget {
  
  const ProjectsSection2({Key? key}): super(key:key);

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
          Container(
            decoration: const BoxDecoration(
                color: Colors.white70,
                backgroundBlendMode: BlendMode.darken
            ),
            child: Text(
              "TRAIN\niNFER\nOPTIMIZE",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 72, color: Colors.white38),
            ),
          ),
          const Text(
            'AI & ML',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.white70
            ),
          ),
          const SizedBox(height: 10),
          const ProjectCardExpandable(
            title: 'Who Looks Like Me ?',
            description: 'Celebrity face similarity predictor.',
            imageUrl: 'assets/who_looks_like_me.png',
            projectUrl: 'http://nikhilshankar.com:8501/',
            years: "2024 Dec - Current",
            subtitle: "* Created \n \n \n How is it ?", ctaText: "Visit Website",
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
                      title: 'Should I Watch It ?',
                      description: 'Youtube movie trailer sentiment analyser',
                      imageUrl: 'assets/should_i_watch_it.png',
                      projectUrl: 'https://github.com/NikhilShankar/ShouldIWatchIt',
                      years: "2024 Dec - Current",
                    ),
                    // Add more ProjectCards as needed
                    ProjectCardAnimated(
                      title: 'AIngel',
                      description: 'LLM based relationship building app.\nThat mutual friend we all wished for.\nCurrently part of Conestoga Venture Tech Lab - CEC Collective',
                      imageUrl: 'assets/aingel.jpg',
                      projectUrl: 'https://project3.com',
                      years: "2024 Oct - Present",
                    ),
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



class ExpandableSocialLinks extends StatefulWidget {
  const ExpandableSocialLinks({super.key});

  @override
  ExpandableSocialLinksState createState() => ExpandableSocialLinksState();
}

class ExpandableSocialLinksState extends State<ExpandableSocialLinks> with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggleExpand(bool expand) {
    setState(() {
      isExpanded = expand;
      if (expand) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: MouseRegion(
        onEnter: (_) => kIsWeb ? _toggleExpand(true) : null,  // Expand on hover (Web)
        onExit: (_) => kIsWeb ? _toggleExpand(false) : null,  // Collapse on hover out (Web)
        child: GestureDetector(
          onTap: () => _toggleExpand(!isExpanded),  // Expand on tap (Mobile)
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: SizeTransition(
                  sizeFactor: _animation,
                  axisAlignment: -1.0, // Expands upwards
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildIconButton("assets/icon_linkedin.png", "LinkedIn"),
                      _buildIconButton("assets/icon_github.png", "GitHub"),
                      _buildIconButton("assets/icon_bitbucket.png", "Bitbucket"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 28,
                height: 28,
                child: FloatingActionButton(
                  onPressed: () => _toggleExpand(!isExpanded),
                  backgroundColor: Colors.grey,
                  shape: const CircleBorder(),
                  mini: true,
                  child: const Icon(Icons.link, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(String icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SizedBox(
        width: 28,
        height: 28,
        child: FloatingActionButton(
          heroTag: tooltip,  // Avoid hero animation conflicts
          onPressed: () => print("$tooltip clicked"),
          backgroundColor: Colors.grey,
          mini: true,
          tooltip: tooltip,
          shape: const CircleBorder(),
          child: Container(
            width: double.infinity, // 100% width
            height: double.infinity, // 75% of the available height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(icon),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


