import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/data/models/usuario.dart';
import 'package:storePlace/src/data/models/usuariosAll.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';
// import 'package:storePlace/src/urls/urls.dart' as urls;

class DetalleUsuarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _api = AutenticationProvider();
    final UsuarioAll data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        //  iconTheme: IconThemeData(color: btnSecundaryColor),
        title: Text('Detalle del Usuario'),
        actions: [
          FlatButton(
            splashColor: Colors.transparent,
            // splashRadius: 25.0,
            child: Icon(
              FontAwesomeIcons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'editUsuario',arguments:data);
            },
          )
        ],
      ),
      body: Container(
        // color: Colors.red,
        width: size.wp(100),
        height: size.hp(100),
        // margin: EdgeInsets.symmetric(horizontal: size.dp(0.5),vertical: size.dp(0.2)),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: 
          FutureBuilder(
            future: _api.getUsuario(data.id),
            builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
              final Responsive size = Responsive.of(context);
              if (snapshot.hasData) {
                final usuario = snapshot.data;
                return infoUsuario(size, context, usuario); 
               
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

  Column infoUsuario(Responsive size,BuildContext context, Usuario usuario) {
    return Column(
          children: [
            InputForm(
              size: size,
              label: 'Cédula',
              data: '${usuario.cedula}'
            ),
            InputForm(
              size: size,
              label: 'Apellidos y Nombres',
              data: '${usuario.nombres}',
            ),
            InputForm(
              size: size,
              label: 'Celular',
              data: '${usuario.celular}',
            ),
             InputForm(
              size: size,
              label: 'Correo',
              data: '${usuario.email}',
            ),
            InputForm(
              size: size,
              label: 'Código',
              data: '${usuario.codigo}',
            ),
            
            InputForm(
              size: size,
              label: 'Tipo de usuario',
              data: '${usuario.rol}',
            ),
          ],
        );
  }
}

class InputForm extends StatelessWidget {
  final String label;
  final String data;

  const InputForm({
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
