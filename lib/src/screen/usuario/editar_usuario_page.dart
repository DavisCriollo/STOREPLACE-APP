import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/data/models/usuario.dart';
import 'package:storePlace/src/data/models/usuariosAll.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';

import 'package:storePlace/src/screen/usuario/usuario_Controlle.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/dialogs.dart';
import 'package:storePlace/src/utils/responsive.dart';

class EditUsuarioPage extends StatefulWidget {
  @override
  _EditUsuarioPageState createState() => _EditUsuarioPageState();
}

class _EditUsuarioPageState extends State<EditUsuarioPage> {
  final _keyFormEditUser = GlobalKey<FormState>();
  String _nombre, _cedula, _email, _celular, _codigo, _rol;

  final _api = AutenticationProvider();
  void _submit(BuildContext context, UsuarioAll usuario) async {
    if (_rol == null) {
      _rol = usuario.rol;
    }
    final isOk = _keyFormEditUser.currentState.validate();
    if (isOk) {
      _keyFormEditUser.currentState.save();
      print('================');
      print('ID=> ${usuario.id}');
      print('cedula=> $_cedula');
      print('nombres=> $_nombre');
      print('email=> $_email');
      print('codigo=> $_codigo');
      print('celular=> $_celular');
      print('TIPO USUARIO=> ${usuario.rol}');
      print('todos llenos');
      ProgressDialog.show(context);
      final response = await _api.uptadeUsuario(
          usuario.id, _nombre.toUpperCase(), _celular, _email, _codigo, _rol);
      ProgressDialog.dissmiss(context);
      if (response != null) {
        Navigator.pushReplacementNamed(context, 'homeSearchUsuario');
      } else {
        Dialogs.alert(
          context,
          title: 'ERROR',
          description:
              'No se actualizó el registro, verifique información completa',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    final UsuarioAll data = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider(
      create: (_) => UserController(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: btnSecundaryColor),
            title: Text('Editar Usuario'),
            actions: [
              FlatButton(
                splashColor: Colors.transparent,
                // splashRadius: 25.0,
                child: Icon(FontAwesomeIcons.save, color: Colors.white),
                onPressed: () {
                  _submit(context, data);
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
              child: Form(
                key: _keyFormEditUser,
                child: FutureBuilder(
                  future: _api.getUsuario(data.id),
                  builder:
                      (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
                    final Responsive size = Responsive.of(context);
                    if (snapshot.hasData) {
                      final usuario = snapshot.data;
                      return formEditaUsuario(size, context, usuario);
                    } else {
                      return Container(
                          height: size.hp(100.0),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: size.dp(2.0)),
                                child: Text('Preparando Información...'),
                              ),
                              CircularProgressIndicator(),
                            ],
                          )));
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column formEditaUsuario(
      Responsive size, BuildContext context, Usuario usuario) {
    return Column(
      children: [
        Column(
          children: [
            InputEditForm(
              size: size,
              label: 'Cédula',
              readOnly: true,
              initialValue: usuario.cedula,
              onSaved: (value) {
                _cedula = value;
              },
              validator: (text) {
                if (text.trim().length == 10 || text.trim().length == 13) {
                  return null;
                } else {
                  return 'Ingrese Cédula';
                }
              },
            ),
            InputEditForm(
              size: size,
              label: 'Apellidos y Nombres',
              initialValue: usuario.nombres,
              onSaved: (value) {
                _nombre = value;
              },
              validator: (text) {
                if (text.trim().length > 0) {
                  return null;
                } else {
                  return 'Ingrese Nombre';
                }
              },
            ),
            InputEditForm(
              size: size,
              label: 'Celular',
              initialValue: usuario.celular,
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _celular = value;
              },
              validator: (text) {
                if (text.trim().length > 0) {
                  return null;
                } else {
                  return 'Ingrese número de Celular';
                }
              },
            ),
            InputEditForm(
              size: size,
              label: 'Correo',
              initialValue: usuario.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                _email = value;
              },
              validator: (text) {
                if (text.trim().length > 0) {
                  return null;
                } else {
                  return 'Ingrese Correo';
                }
              },
            ),
            InputEditForm(
              size: size,
              label: 'Código',
              initialValue: usuario.codigo,
              onSaved: (value) {
                _codigo = value;
              },
              validator: (text) {
                if (text.trim().length > 0) {
                  return null;
                } else {
                  return 'Ingrese Código';
                }
              },
            ),
          ],
        ),
        Consumer<UserController>(builder: (_, controller, __) {
          return Column(
            children: [
              Container(
                width: size.wp(100),
                margin: EdgeInsets.only(top: size.dp(1.0), left: size.dp(1.0)),
                child: Text('Tipo de Usuario',
                    style: GoogleFonts.roboto(
                      fontSize: size.dp(1.7),
                      fontWeight: FontWeight.w500,
                      color: textSecundaryColor,
                    )),
              ),
              Container(
                color: Colors.white.withOpacity(0.15),
                padding: EdgeInsets.only(left: size.dp(2.0)),
                alignment: Alignment.center,
                child: DropdownButton(
                  iconSize: size.dp(3.0),

                  isExpanded: true,
                  hint: Text(
                    'Seleccione Rol',
                    style: GoogleFonts.roboto(
                      fontSize: size.dp(1.7),
                      fontWeight: FontWeight.w500,
                      color: textSecundaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  value: (_rol == null)
                      ? usuario.rol
                      : controller.selected, //zona.getZona,
                  style: GoogleFonts.roboto(
                    fontSize: size.dp(1.7),
                    fontWeight: FontWeight.normal,
                    color: textPrimaryColor,
                  ),
                  items: controller.getRol
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _rol = value;
                    controller.setSelectedItem(value);
                  },
                ),
                // }),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class InputEditForm extends StatelessWidget {
  final String label;
  final bool autofocus;

  final bool readOnly;
  final TextInputType keyboardType;
  final String initialValue;
  final void Function(String text) onChanged;
  final String Function(String) validator;
  final void Function(String) onSaved;

  const InputEditForm({
    Key key,
    @required this.size,
    @required this.label,
    this.readOnly = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.onSaved,
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
                // fontWeight: FontWeight.w500,
                color: Colors.black45,
              )),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: size.wp(3.0)),
          child: TextFormField(
            onSaved: this.onSaved,
            autofocus: this.autofocus,
            keyboardType: this.keyboardType,
            readOnly: this.readOnly,
            initialValue: this.initialValue,
            textInputAction: TextInputAction.none,
            onChanged: this.onChanged,
            validator: this.validator,
          ),
        ),
      ],
    );
  }
}
