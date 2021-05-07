import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';

abstract class FontStyle {
  final Responsive size;
  FontStyle(this.size);
  static final title = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  

}
