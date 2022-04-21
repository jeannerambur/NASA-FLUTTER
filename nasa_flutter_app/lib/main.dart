import 'package:flutter/material.dart';
import 'package:nasa_flutter_app/home_page.dart';
import 'package:nasa_flutter_app/welcome_page.dart';

void main() => runApp(Infinity());

class Infinity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA APP',
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: WelcomePage(),
    );
  }
}