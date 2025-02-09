import 'package:flutter/material.dart';
import 'package:portfolio/ui/widgets/responsive/ProfileSummaryWidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Mobile layout
    return Scaffold(
      appBar: AppBar(
        title: const Text('NIXAC LABS'),
      ),
      drawer: _buildDrawer(), // Drawer for mobile hamburger menu
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Desktop or large screen layout
            return Row(
              children: [
                _buildLeftColumn(), // Left column for larger screens
                Expanded(child: _buildMainContent()), // Main content area
              ],
            );
          } else {
            // Mobile layout
            return _buildMainContent();
          }
        },
      ),
    );
  }

  // Left Column for web and large screens
  Widget _buildLeftColumn() {
    return Container(
      width: 250,
      color: Colors.blueGrey[800],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard('About Me'),
          _buildCard('My Projects'),
          _buildCard('Contact'),
          _buildCard('Experience'),
          _buildCard('Resume'),
        ],
      ),
    );
  }

  // Card-based design for each menu item
  Widget _buildCard(String title) {
    return Card(
      color: Colors.blueGrey[600],
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        onTap: () {
          // Handle tap on the menu item
          print('$title tapped');
        },
      ),
    );
  }

  // Main content area
  static Widget _buildMainContent() {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileSummary(),
              SizedBox(height: 20),
              Text(
                  '"One learns from books and example only that certain things can be done. Actual learning requires that you do those things." ~ Frank Herbert',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer widget for mobile (Hamburger Menu)
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem('Projects'),
          _buildDrawerItem('Experience'),
          _buildDrawerItem('Resume'),
          _buildDrawerItem('About Me'),
          _buildDrawerItem('Contact'),
        ],
      ),
    );
  }

  // Drawer header
  Widget _buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text('Nikhil Shankar'),
      accountEmail: Text('nikhil.shankar.cs@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/passport_nikhil.jpg'), // Local image
        backgroundColor: Colors.transparent,
        radius: 60
      ),
    );
  }

  // Drawer item (links)
  Widget _buildDrawerItem(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close drawer after tap
        print('$title tapped');
      },
    );
  }

  // Drawer item (links)
  Widget _buildDrawerItemMobile(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        print('$title tapped');
      },
    );
  }

}
