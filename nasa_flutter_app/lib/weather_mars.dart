import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: NasaApp(),
));

class NasaApp extends StatefulWidget {
  @override
  _NasaAppState createState() => _NasaAppState();
  
}

class _NasaAppState extends State<NasaApp> {

  // sol is the day number in mars
  // min is for the lowest temperature
  // max is for the highest temperature
  Widget ListItem(String Sol, int min, int max) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0,),
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  "Sol $Sol",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            SizedBox(width: 120,),
            Expanded(
                child: Text(
                  "High: $max°C",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                )
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            SizedBox(width: 120,),
            Expanded(
                child: Text(
                  "Low: $min°C",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ),
          ],
        ),
        SizedBox(height: 10.0,),
        Container(
          height: 2.0,
          width: double.infinity,
          color: Colors.white,
        ),
      ],
    );
  }


  //API
  String Url = "https://mars.nasa.gov/rss/api/?feed=weather&category=insight_temperature&feedtype=json&ver=1.0";
  var Sol_key;
  var Data;
  List weather_data = [];

  //http request function
  Future<void> getData() async {
    http.Response response = await http.get(
        Uri.parse(Url),
    );
    setState(() {
      Data = json.decode(response.body);
      Sol_key = Data["sol_keys"];
      Sol_key = Sol_key.reversed.toList();
      for(int i=0; i< Sol_key.length; i++) {
        weather_data.add(Data[Sol_key[i]]["AT"]);
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
      appBar: AppBar(
        title: Text(
          "March Weather",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        elevation: 16.0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../_assets/mars_bg.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Lastest Weather\nat Elysium Planitia",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 28.0
                ),
              ),
              SizedBox(height: 30.0,),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        "Sol ${Sol_key[0]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        "High: ${(weather_data[0]["mx"]).ceil()}°C",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        "Today ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                  Expanded(
                      child: Text(
                        "Low: ${(weather_data[0]["mn"]).ceil()}°C",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 60.0,),
              Text(
                "Previous Days",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 28.0,
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                height: 3.0,
                width: double.infinity,
                color: Colors.white,
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: Sol_key.length,
                      itemBuilder: (BuildContext, int index){
                        return ListItem(Sol_key[index], (weather_data[index]["mn"]).ceil(), (weather_data[index]["mx"]).ceil());
                      }
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

