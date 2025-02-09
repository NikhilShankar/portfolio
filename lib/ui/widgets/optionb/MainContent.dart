import 'package:flutter/material.dart';
import 'package:portfolio/ui/widgets/optionb/HoverImageWidget.dart';
import 'package:portfolio/ui/widgets/optionb/ImageWithTitleAndSubtitle.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final int index;
  final Widget child;  // Child widget added

  const SectionWidget({
    required this.title,
    required this.index,
    required this.child,  // Required child widget
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      height: 600,
      padding: const EdgeInsets.all(16.0),
      color: index % 2 == 0 ? Colors.white : Colors.grey.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(seconds: 1),
            child: Center(
              child: Text(
                textAlign: TextAlign.right,
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          const SizedBox(height: 20),
          child,  // Use the child widget here
        ],
      ),
    );
  }
}


class HoverCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const HoverCard({required this.title, required this.subtitle, required this.imagePath, Key? key}) : super(key: key);

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          boxShadow: isHovered
              ? [const BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)]
              : [],
          borderRadius: isHovered? BorderRadius.circular(12.0): BorderRadius.circular(2.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image section with overlay and title
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Opacity(
                    opacity: isHovered ? 0.7 : 0.9,
                    child: Image.asset(
                      widget.imagePath, // Replace with your image path
                      height: 180, // Adjust based on design
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        const Shadow(
                          blurRadius: 4.0,
                          color: Colors.black54,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Subtitle section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isHovered ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _isScrolled = _scrollController.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.black,
            pinned: true,
            expandedHeight: 10.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_isScrolled ? 'NS' : '', style:const TextStyle(color:Colors.white)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: isMobile? const EdgeInsets.all(8.0): const EdgeInsets.fromLTRB(128.0, 64.0, 128.0, 32.0),
                  child: const HoverImageWidget(imageUrl: 'assets/nikki.jpg', subtitle: 'Hey I am Nikhil, here I showcase things Im passionate about ! Don\'t forget to check the blog section if you are interested in learning', title: '',),
                ),
                Container(
                  color: Colors.teal[900],
                  child: const ImageWithTitleAndSubtitle(
                    imageUrl: 'assets/nikki.jpg',
                    subtitle: 'Awesome',
                    title: 'Slice',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile? NavigationBar(
        destinations: List.generate(
          _sectionKeys.length,
              (index) => NavigationDestination(
            icon: const Icon(Icons.circle),
            label: 'Section ${index + 1}',
          ),
        ),
        onDestinationSelected: (index) {
          final targetContext = _sectionKeys[index].currentContext;
          if (targetContext != null) {
            Scrollable.ensureVisible(
              targetContext,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
      ): null,
    );
  }
}



//////////////////////// Profile Section
