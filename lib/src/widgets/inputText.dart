import 'package:flutter/material.dart';
import 'package:storePlace/src/utils/responsive.dart';


class InputForm extends StatelessWidget {



  

  @override
  Widget build(BuildContext context) {
   final Responsive size = Responsive.of(context);
    return TextFormField(
      textInputAction: TextInputAction.none,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          suffixIcon: Icon(
        Icons.vpn_key,
        color: Colors.grey,
      )),
      style: TextStyle(
        letterSpacing: 2.0,
        fontSize: size.dp(3.0),
        fontWeight: FontWeight.bold,
      ),
      onChanged: (text){
        print(text);
      },
    );
  }
  }
