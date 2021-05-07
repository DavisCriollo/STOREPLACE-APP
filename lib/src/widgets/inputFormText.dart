import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/utils/responsive.dart';

class InputTextForm extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool readOnly;
  final bool  obscureText;
  final TextInputType keyboardType;
  final void Function(String text) onChanged;
  final String Function(String text) validator;

  const InputTextForm({
    Key key,
    @required this.size,
    @required this.label,
    this.initialValue,
    this.readOnly = false,
    this.keyboardType = TextInputType.text, 
    this.obscureText=false, this.onChanged, 
    @required this.validator,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.wp(100),
          margin:
              EdgeInsets.only(top: size.dp(1.0), left: size.dp(1.0)),
          child: Text(this.label,
              style: GoogleFonts.roboto(
                fontSize: size.dp(1.7),
                // fontWeight: FontWeight.w500,
                color: Colors.black45,
              )),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.wp(3.0)),
          child: TextFormField(
            readOnly: this.readOnly,
            keyboardType: this.keyboardType,
            obscureText:this.obscureText ,
            initialValue: this.initialValue ,
            textInputAction: TextInputAction.none,
            style: TextStyle(
                // letterSpacing: 2.0,
                // fontSize: size.dp(3.0),
                // fontWeight: FontWeight.bold,
                ),
                onChanged: this.onChanged,
                validator:this.validator ,
          ),
        ),
      ],
    );
  }
}
