import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/data/models/codeLogin.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/data/providers/auth_storage.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/dialogs.dart';
import 'package:storePlace/src/utils/responsive.dart';

class CodePage extends StatefulWidget {
  CodePage({Key key}) : super(key: key);

  @override
  _CodePageState createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  //  AutenticationStorage token ;

  GlobalKey<FormState> _forKeyCode = GlobalKey();
  String _code = "";
  final _api = AutenticationProvider();
  // Logger _logger = Logger();

  void _submit() async {
    final isOk = _forKeyCode.currentState.validate();
    if (isOk) {
      //======= MUESTRO UN PROGRES DIALOGO =====//
      ProgressDialog.show(context);
      //==================================//
      final response = await _api.loginCode(code: _code);
      //======= OCULTO PROGRES DIALOGO =====//
      ProgressDialog.dissmiss(context);
      if (response.data != null) {
        //  await  token.saveSession(response.data);
        final data = CodeLogin.fromJson(response.data);
        await Auth.instance.setSession(data);
        Navigator.pushReplacementNamed(context, 'homeSearchCliente');
      } else {
        // _logger.e('REGISTER ERRORCODE: ${response.error.statusCode}');
        // _logger.e('REGISTER ERRORMESSAGE: ${response.error.message}');
        // _logger.e('REGISTER ERRORDATA: ${response.error.data}');

        String message = response.error.message;

        if (response.error.statusCode == -1) {
          message = 'Sin acceso a Intenet';
        } else if (response.error.statusCode == 400) {
          message = '${jsonEncode(response.error.data['msg'])}';
        } else if (response.error.statusCode == 404) {
          message = 'Servidor no Conectado';
        }

        Dialogs.alert(
          context,
          title: 'ERROR',
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            // color: Colors.red,
            width: size.wp(100),
            height: size.hp(100),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                //  color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Text('Store Place',
                          style: GoogleFonts.roboto(
                              fontSize: size.dp(5.0),
                              color: btnPrimaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: size.dp(6.0)),
                      child: SvgPicture.asset(
                        'assets/imgs/logo.svg',
                        width: size.dp(25.0),
                      ),
                    ),
                    Container(
                      // color: Colors.blue,
                      child: Text('Ingrese su código de verificación',
                          style: GoogleFonts.roboto(
                              fontSize: size.dp(2.0),
                              color: textPrimaryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: size.wp(30.0)),
                          child: Form(
                            key: _forKeyCode,
                            child: TextFormField(
                              validator: (text) {
                                if (text.trim().length > 0) {
                                  return null;
                                } else {
                                  return 'Código Invalido';
                                }
                              },
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
                              onChanged: (text) {
                                _code = text;
                                print(_code);
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.dp(5.0), vertical: size.dp(3.0)),
                          decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: MaterialButton(
                              child: Text('Ingresar',
                                  style: GoogleFonts.roboto(
                                      fontSize: size.dp(2.0),
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                              onPressed: this._submit),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
