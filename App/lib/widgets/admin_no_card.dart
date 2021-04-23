import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class adminNoCard extends StatelessWidget {
  const adminNoCard({
    Key key,
    @required this.count,
    @required this.title,
    @required this.color1,
    @required this.color2,
  }) : super(key: key);

  final int count;
  final String title;
  final color1;
  final color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width*0.4,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              color1,color2
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            
            Text(
              title,
              maxLines: 2,
               overflow: TextOverflow.ellipsis,
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              count.toString(),
              style: GoogleFonts.oswald(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ));
  }
}
