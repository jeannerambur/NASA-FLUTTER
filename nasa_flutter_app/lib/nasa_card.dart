import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_ink_well/image_ink_well.dart';

import 'detail.dart';
import 'model.dart';

class NasaCard extends StatelessWidget {
  final Nasa nasa;

  const NasaCard({required Key key, required this.nasa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16.0,
      margin: EdgeInsets.all(20),
      color: Color.fromRGBO(191, 69, 69, 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 600,
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                ),
              ),
              Hero(
                tag: nasa.date,
                child: RoundedRectangleImageInkWell(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(nasa: nasa),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(
                    (12.0),
                  ),
                  width: 600,
                  height: 300,
                  fit: BoxFit.cover,
                  backgroundColor: Colors.transparent,
                  image: CachedNetworkImageProvider(nasa.url),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 20, 20), //apply padding to LTRB, L:Left, T:Top, R:Right, B:Bottom
            child: Text(
              nasa.title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}