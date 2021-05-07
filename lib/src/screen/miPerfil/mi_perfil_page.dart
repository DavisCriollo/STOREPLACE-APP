import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:storePlace/src/data/models/usuario.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/screen/miPerfil/perfil_controller.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';

class MiPerfilPage extends StatefulWidget {
  @override
  _MiPerfilPageState createState() => _MiPerfilPageState();
}

class _MiPerfilPageState extends State<MiPerfilPage> {
  final controller = PerfilController();

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _api = AutenticationProvider();
    final String _userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
        actions: [
          FlatButton(
            splashColor: Colors.transparent,
            child: Icon(
              FontAwesomeIcons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'editPerfil', arguments: _userId);
            },
          )
        ],
      ),
      body: Container(
        width: size.wp(100),
        height: size.hp(100),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FutureBuilder(
            future: _api.getUsuario(_userId),
            builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
              final Responsive size = Responsive.of(context);
              if (snapshot.hasData) {
                final usuario = snapshot.data;
                return infoPerfilUsuario(size, context, usuario);
              } else {
                return Container(
                    height: size.hp(100.0),
                    child: Center(child: CircularProgressIndicator()));
              }
            },
            // infoUsuario(size),
          ),
        ),
      ),
    );
  }

  Column infoPerfilUsuario(
      Responsive size, BuildContext context, Usuario usuario) {
    return Column(
      children: [
        InputPerfilForm(
          size: size,
          label: 'Cédula',
          data: '${usuario.cedula}',
        ),
        InputPerfilForm(
          size: size,
          label: 'Apellidos y Nombres',
          data: '${usuario.nombres}',
        ),
        InputPerfilForm(
          size: size,
          label: 'Celular',
          data: '${usuario.celular}',
        ),
        InputPerfilForm(
          size: size,
          label: 'Correo',
          data: '${usuario.email}',
        ),
        InputPerfilForm(
          size: size,
          label: 'Código',
          data: '${usuario.codigo}',
        ),
        InputPerfilForm(
          size: size,
          label: 'Tipo de usuario',
          data: '${usuario.rol}',
        ),
      ],
    );
  }
}

class InputPerfilForm extends StatelessWidget {
  final String label;
  final String data;

  const InputPerfilForm({
    Key key,
    @required this.size,
    @required this.label,
    @required this.data,
  }) : super(key: key);

  final Responsive size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // APELLIDO Y NOMBRE
        Container(
          width: size.wp(100),
          margin: EdgeInsets.only(top: size.dp(1.0), left: size.dp(1.0)),
          child: Text(this.label,
              style: GoogleFonts.roboto(
                fontSize: size.dp(1.7),
                fontWeight: FontWeight.w500,
                color: textSecundaryColor,
              )),
        ),
        Container(
          padding: EdgeInsets.all(
            size.dp(1.0),
          ),
          margin: EdgeInsets.only(bottom: size.dp(0.5)),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
          width: size.wp(100),
          child: SelectableText(this.data,
              style: GoogleFonts.roboto(
                fontSize: size.dp(1.7),
                fontWeight: FontWeight.normal,
                color: textPrimaryColor,
              )),
        ),
      ],
    );
  }
}
