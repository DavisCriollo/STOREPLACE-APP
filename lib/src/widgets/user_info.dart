import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/data/models/session.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/data/providers/auth_storage.dart';

import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  final _api = AutenticationProvider();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getStorage();
    });
  }

  void _getStorage() async {
     final Session session = await Auth.instance.getSession();
          _api.getUsuario( session.id);
  
  
    // if (session != null) {
    //   Navigator.pushReplacementNamed(context, 'home');
    // } else {
    //   Navigator.pushReplacementNamed(context, 'code');
    // }
    print('${session.rol}');
    }

  @override
  Widget build(BuildContext context) {
    
    // print('_user');
    // print('_rol');
    //
    // String alias;
    // final List<String> tmp = user.info.nombre.split(" ");
    // if (tmp.length > 0) {
    //   alias = tmp[0][0];
    //   if (tmp.length >= 2) {
    //     alias += tmp[2][0];
    //   }
    // }
    final size = Responsive.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.dp(2.0),
      ),
      alignment: Alignment.center,

      width: size.wp(100),
      // height: size.wp(46.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(size.dp(0.5)),
            decoration: BoxDecoration(
              // color: Color(0xFF0070EC),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: primaryColor, width: 5.0),
            ),
            width: size.dp(13),
            height: size.dp(13),
            child: Text(
              // '$alias',
              '_user',
              // '${user.info.estado}',
              // '',
              style: GoogleFonts.roboto(
                fontSize: size.dp(5.0),
                fontWeight: FontWeight.bold,
                color: btnSecundaryColor,
              ),
            ),
          ),

          //*******************************************/
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                // color:Colors .red,
                margin: EdgeInsets.only(top: size.dp(2.0)),
                child: Text(
                  // '${user.info.nombre}',
                  'ddadDANIEL MARTINEZ MEZA RODRIGUEZ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: size.dp(1.6),
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                // color:Colors .red,
                margin: EdgeInsets.only(
                  top: size.dp(0.5),
                ),
                child: Text(
                  // '${user.info.usuario} ',
                  '456445454565',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: size.dp(1.5),
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
