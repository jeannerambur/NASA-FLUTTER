import 'package:flutter/material.dart';
import 'package:nasa_flutter_app/home.dart';
import 'package:nasa_flutter_app/home_page.dart';
import 'package:nasa_flutter_app/delayed_animation.dart';
import 'package:nasa_flutter_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasa_flutter_app/weather_mars.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 7, 37, 1),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: Column(
            children: [
              DelayedAnimation(
                delay: 1500,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  height: 300,
                  child: Image.asset('../_assets/planet.jpg'),
                ),
              ),
              DelayedAnimation(
                delay: 2000,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 300,
                    bottom: 20,
                  ),
                  child: Text(
                    "Come and discover the most beautiful images from NASA",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              DelayedAnimation(
                delay: 2500,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(166, 56, 56, 1),
                        shape: StadiumBorder(),
                        padding: EdgeInsets.all(20)),
                    child: Text('GET STARTED'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Nasa APP'),
                        ),
                      );
                    },
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