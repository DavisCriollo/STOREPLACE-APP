
import 'package:flutter/material.dart';

import 'package:storePlace/src/data/models/session.dart';

import 'package:storePlace/src/data/providers/auth_storage.dart';
import 'package:storePlace/src/utils/responsive.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
// VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chechLogin();
    });
  }

  _chechLogin() async {
    final Session session = await Auth.instance.getSession();
    if (session != null) {
      Navigator.pushReplacementNamed(context, 'homeSearchCliente');
    } else {
      Navigator.pushReplacementNamed(context, 'code');
    }
  }

  @override
  Widget build(BuildContext context) {
        final Responsive size = Responsive.of(context);
    return Scaffold(
      body: Container(
        width: size.wp(100.0),
        height: size.hp(100.0),
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text('Procesando.... '),
            ],
          ),
        ),
      ),
    );
  }
}
