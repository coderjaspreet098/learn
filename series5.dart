import 'package:flutter/material.dart';
import 'package:newproject/series21.dart';
import 'package:newproject/series22.dart';
import 'package:newproject/series23.dart';
import 'series20.dart';

class Demopage extends StatelessWidget {
  const Demopage({super.key});

  static const apptitle = 'Drawer Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: apptitle,
      home: Drawerdemo(title: apptitle),
    );
  }
}

class Drawerdemo extends StatefulWidget {
  const Drawerdemo({super.key, required this.title});

  final String title;

  @override
  State<Drawerdemo> createState() => _DrawerdemoState();
}

class _DrawerdemoState extends State<Drawerdemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1693146604593-f533da0f55ed?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0NnxibzhqUUtUYUUwWXx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60'),
                    fit: BoxFit.cover),
              ),
              child: Text(
                'Header',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('First'),
              leading: Icon(Icons.star),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Firstpage()),
                );
              },
            ),
            ListTile(
              title: Text('Second'),
              leading: Icon(Icons.star),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
            ),
            ListTile(
              title: Text('Third'),
              leading: Icon(Icons.star),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
            ),
            ListTile(
              title: Text('Fourth'),
              leading: Icon(Icons.star),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FourthPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
