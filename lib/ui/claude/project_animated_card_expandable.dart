// main.dart
import 'package:flutter/material.dart';
import 'package:portfolio/ui/claude/dark_bg.dart';
import 'package:portfolio/ui/claude/star_bg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Detect web environment


class ProjectCardExpandable extends StatefulWidget {
  final String title;
  final String description;
  final String subtitle;
  final String imageUrl;
  final String projectUrl;
  final String years;
  final String ctaText;

  const ProjectCardExpandable({
    super.key,
    required this.title,
    required this.description,
    required this.subtitle,
    required this.imageUrl,
    required this.projectUrl,
    required this.years,
    this.ctaText = 'Learn More',
  });

  @override
  State<ProjectCardExpandable> createState() => _ProjectCardExpandable();
}

class _ProjectCardExpandable extends State<ProjectCardExpandable> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _slideAnimationToTop;
  late Animation<double> _fadeAnimation;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool isVisible = false;
  bool isExpanded = false;
  bool isHovered = false;
  final GlobalKey _mainContentKey = GlobalKey();
  final GlobalKey _expandedContentKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimationToTop = Tween<Offset>(
      begin: const Offset(0, 5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !isVisible) {
      setState(() {
        isVisible = true;
      });
      _controller.forward();
    } else if (info.visibleFraction == 0 && isVisible) {
      setState(() {
        isVisible = false;
        isExpanded = false;
      });
      _controller.reset();
      _expandController.reset();
    }
  }

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: _toggleExpand,
          child: MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: VisibilityDetector(
              key: Key(widget.title),
              onVisibilityChanged: _onVisibilityChanged,
              child: Container(
                width: constraints.maxWidth,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, isExpanded ? Colors.black87 : Colors.black54, Colors.black],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: SlideTransition(
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
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Main content
                        Container(
                          key: _mainContentKey,
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 48),
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
                                  begin: const Offset(1.5, 0),
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
                        // Expandable content
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Container(
                            key: _expandedContentKey,
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: isExpanded ? 16.0 : 0),
                            constraints: BoxConstraints(
                              maxHeight: isExpanded ? double.infinity : 0,
                            ),
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: isExpanded ? 1.0 : 0.0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.subtitle,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Center(
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            launchUrl(Uri.parse(widget.projectUrl));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              widget.ctaText,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}