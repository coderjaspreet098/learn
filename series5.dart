import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  secondpage1();
  }
}
class secondpage1 extends StatefulWidget {

  const secondpage1({super.key});

  @override
  State<secondpage1> createState() => _secondpage1State();
}

class _secondpage1State extends State<secondpage1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar Example'),
      ),
      body: Center(
        child: Text(
          'Page $_currentIndex',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),

        child: GNav(
          backgroundColor: Colors.purpleAccent,
          tabs: [
            GButton(
              text: 'Home',
              icon: Icons.home,
            ),
            GButton(
              text: 'Search',
              icon: Icons.search,
            ),
            GButton(
              text: 'Favorites',
              icon: Icons.favorite,
            ),
            GButton(
              text: 'Profile',
              icon: Icons.person,
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
