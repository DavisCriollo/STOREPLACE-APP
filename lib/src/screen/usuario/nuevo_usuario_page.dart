import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/screen/usuario/usuario_Controlle.dart';
// import 'package:storePlace/src/pages/usuarios/controlle/user_Controlle.dart';
// import 'package:provider/provider.dart';
// import 'package:storePlace/src/data/providers/geolocatorCurrent.dart';
// import 'package:storePlace/src/pages/usuarios/detalleUsuario.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/dialogs.dart';

import 'package:storePlace/src/utils/responsive.dart';

class NuevoUsuarioPage extends StatefulWidget {
  @override
  _NuevoUsuarioPageState createState() => _NuevoUsuarioPageState();
}

class _NuevoUsuarioPageState extends State<NuevoUsuarioPage> {
  final _keyFormNewUser = GlobalKey<FormState>();
  String _cedula, _nombre, _celular, _email, _codigo, _rol;

  final _api = AutenticationProvider();

  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    // final controller = context.read<UserController>();

    void _submit(BuildContext context) async {
      if (_rol == null) {
        Dialogs.alert(
          context,
          title: 'Seleccione ROL',
          description: 'Debe seleccionar el tipo de Usuario',
        );
      } else {
        final isOk = _keyFormNewUser.currentState.validate();
        if (isOk) {
          print('cedula=> $_cedula');
          print('nombres=> $_nombre');
          print('nombres=> $_celular');
          print('email=> $_email');
          print('codigo=> $_codigo');
          print('rol=> $_rol');
          ProgressDialog.show(context);
          final response = _api.newUsuario(
              _cedula, _nombre.toUpperCase(), _celular, _email, _codigo, _rol);
          ProgressDialog.dissmiss(context);
          if (response != null) {
            Navigator.pushReplacementNamed(context, 'homeSearchUsuario');
            // Navigator.popUntil(context, ModalRoute.withName('usuarios'));
          } else {
            Dialogs.alert(
              context,
              title: 'ERROR',
              description: 'No se pudo registral al Usuario',
            );
          }
        }
      }
    }

    return ChangeNotifierProvider<UserController>(
        create: (_) => UserController(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Nuevo Usuario'),
              actions: [
                FlatButton(
                  splashColor: Colors.transparent,
                  child: Icon(FontAwesomeIcons.save, color: Colors.white),
                  onPressed: () {
                    _submit(context);
                  },
                )
              ],
            ),
            body: Container(
              // color: Colors.red,
              width: size.wp(100),
              height: size.hp(100),

              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Form(
                      key: _keyFormNewUser,
                      child: Column(
                        children: [
                          InputFormNewUser(
                            autofocus: true,
                            size: size,
                            label: 'Cédula',
                            onChanged: (text) {
                              _cedula = text;
                              print(text);
                            },
                            validator: (text) {
                              if (text.trim().length == 10 ||
                                  text.trim().length == 13) {
                                return null;
                              } else {
                                return 'Ingrese Cédula correcta';
                              }
                            },
                          ),
                          InputFormNewUser(
                            size: size,
                            label: 'Apellidos y Nombres',
                            onChanged: (text) {
                              _nombre = text;
                              print(text);
                            },
                            validator: (text) {
                              if (text.trim().length > 0) {
                                return null;
                              } else {
                                return 'Ingrese Apellidos y Nombres';
                              }
                            },
                          ),
                          InputFormNewUser(
                            size: size,
                            label: 'Celular',
                            keyboardType: TextInputType.phone,
                            onChanged: (text) {
                              _celular = text;
                              print(text);
                            },
                            validator: (text) {
                              if (text.trim().length > 0) {
                                return null;
                              } else {
                                return 'Ingrese número de celular';
                              }
                            },
                          ),
                          InputFormNewUser(
                            size: size,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              _email = text;
                              print(text);
                            },
                            validator: (text) {
                              if (text.contains('@')) {
                                return null;
                              } else {
                                return 'Correo Inválido';
                              }
                            },
                          ),
                          InputFormNewUser(
                            size: size,
                            label: 'Código',
                            onChanged: (text) {
                              _codigo = text;
                              print(text);
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
                    ),
                    Consumer<UserController>(builder: (_, controller, __) {
                      return Column(
                        children: [
                          Container(
                            width: size.wp(100),
                            margin: EdgeInsets.only(
                                top: size.dp(1.0), left: size.dp(1.0)),
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
                              value: controller.selected, //zona.getZona,
                              style: GoogleFonts.roboto(
                                fontSize: size.dp(1.7),
                                fontWeight: FontWeight.normal,
                                color: textPrimaryColor,
                              ),
                              items: controller.getRol
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                ),
              ),
            ),
          );
        });
  }
}

class InputFormNewUser extends StatelessWidget {
  final String label;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final String Function(String) validator;
  final bool autofocus;

  const InputFormNewUser({
    Key key,
    @required this.size,
    @required this.label,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.autofocus = false,
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
            autofocus: this.autofocus,
            keyboardType: this.keyboardType,
            textInputAction: TextInputAction.none,
            onChanged: this.onChanged,
            validator: this.validator,
            textCapitalization: TextCapitalization.words,
          ),
        ),
      ],
    );
  }
}
