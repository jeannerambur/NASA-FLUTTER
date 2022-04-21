import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_flutter_app/weather_mars.dart';

import 'model.dart';
import 'nasa_card.dart';
import 'error.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<Nasa>> nasa;
  final String uri = "http://localhost:3000/api/?count=5";

  get key => null;

  Future<List<Nasa>> fetchNasa() async {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body);

      if (jsonList is List ) {
        return jsonList.map((json) => Nasa.fromJson(json)).toList();
      }
    }
    throw Exception("Http call not made");
  }

  @override
  void initState() {
    super.initState();
    nasa = fetchNasa();
    //TODO
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(2, 7, 37, 1),
          appBar: AppBar(
            title: Text(
              "Infinity",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            elevation: 16.0,
            centerTitle: true,
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.autorenew), onPressed: () {
                setState(() {
                  nasa = fetchNasa();
                });
              })
            ],
          ),
          body: FutureBuilder(
            future: nasa,
            builder: (BuildContext context, AsyncSnapshot<List<Nasa>> snapshot){
              if(snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(20.0),
                  children: snapshot.data!.map((nasa) => NasaCard(nasa: nasa, key: key,)).toList(),
                );
              }
              else if(snapshot.hasError) {
                return Error(error: snapshot.error, title: '',);
              }
              else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                );
              }
            },
          ),

        ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Future<List<Nasa>>>('nasa', nasa));
  }
}