import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://cdn.pixabay.com/photo/2016/11/21/12/39/stars-1845140_1280.jpg',
            ),
          )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Infinity",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                  padding: EdgeInsets.all(16.0),
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