import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/utils/responsive.dart';

class BannerSinDatos extends StatelessWidget {
  final String label;
  const BannerSinDatos({
    Key key,
    @required this.size,
    @required this.label,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size.dp(5.0)),
      // color: Colors.red,
      width: size.dp(100.0),
      child: Center(
        child:
         Text('No tiene ${this.label} registrados actuelmente',textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: size.dp(2.0),
                color: Colors.black45,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}