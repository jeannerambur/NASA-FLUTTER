import 'package:flutter/material.dart';
import 'package:nasa_flutter_app/rover_page.dart';
import 'package:nasa_flutter_app/weather_mars.dart';

import 'home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screen = [
    HomePage(),
    NasaApp(),
    RoverPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index) ,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromRGBO(166, 56, 56, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
            backgroundColor: Color.fromRGBO(166, 56, 56, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Rover',
            backgroundColor: Color.fromRGBO(166, 56, 56, 1),
          ),
        ],
      ),
    );
  }
}
