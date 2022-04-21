import 'dart:convert';
import 'dart:async';
import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RoverPage extends StatefulWidget {
  @override
  _RoverPageState createState() => _RoverPageState();

}

class _RoverPageState extends State<RoverPage> {

  Widget ListItem(String img, String camRover) {
     return Card(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
       child: Stack(
         alignment: Alignment.center,
         children: <Widget>[
            Ink.image(
              image: CachedNetworkImageProvider("$img"),
              height: 240,
              fit: BoxFit.cover,
            ),
           Positioned(
             bottom: 16,
             right: 16,
             left: 16,
             child: Text(
               'camera: $camRover ',
               style: TextStyle(
                 fontWeight: FontWeight.w600,
                 color: Colors.white,
                 fontSize: 24,
               ),
             ),
           ),
         ],
       ),
     );
  }

  //API
  String Url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2022-4-19&api_key=qljPS8rVhhhyueZbjPyEpj9hud7sHtUiIb2iMzhI&page=1";
  var photos;
  var Data;
  List photos_data = [];


  //http request function
  Future<void> getData() async {
    http.Response response = await http.get(
      Uri.parse(Url),
    );
    setState(() {
      Data = json.decode(response.body);
      photos = Data["photos"];
      photos = photos.reversed.toList();
      for(int i=0; i< photos.length; i++) {
        photos_data.add(photos[i]);
      }
    });
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 7, 37, 1),
      appBar: AppBar(
        title: Text(
          "Rover",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        elevation: 16.0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Curiosity Rover Photos",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(height: 30.0,),
              Expanded(
                child: ListView.builder(
                    itemCount: photos.length,
                    itemBuilder: (BuildContext, int index){
                      return ListItem(photos_data[index]["img_src"], photos_data[index]["camera"]["name"]);
                    }
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
