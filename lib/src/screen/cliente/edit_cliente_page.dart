import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/data/models/cliente.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';

import 'package:storePlace/src/screen/cliente/cliente_controller.dart';

import 'package:storePlace/src/utils/dialogs.dart';

import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/utils/theme.dart';

class EditarClientePage extends StatefulWidget {
  @override
  _EditarClientePageState createState() => _EditarClientePageState();
}

class _EditarClientePageState extends State<EditarClientePage> {
  final _keyFormNuevoCliente = GlobalKey<FormState>();
  // final _api = AutenticationProvider();
  String _cedula,
      _nombre,
      _telefono,
      _correo,
      _direccion,
      _observacion,
      _coordenadas;

  @override
  Widget build(BuildContext context) {
    final _api = AutenticationProvider();
    final String _id = ModalRoute.of(context).settings.arguments;

    void _submit(BuildContext context) async {
      final _latLong =
          Provider.of<ClienteController>(context, listen: false).selectCoords;
      _coordenadas = _latLong;

      if (_coordenadas == "") {
        Dialogs.alert(context,
            title: 'Sin Ubicación',
            description: 'Debe obtener la ubicación del cliente');
      } else {
        final isOk = _keyFormNuevoCliente.currentState.validate();
        if (isOk) {
          _keyFormNuevoCliente.currentState.save();
          //======= MUESTRO UN PROGRES DIALOGO =====//
          ProgressDialog.show(context);
          //==================================//
          print('_cedula=> $_cedula');
          print('_nombre=> $_nombre');
          print('_telefono=> $_telefono');
          print('_correo=> $_correo');
          print('_direccion=> $_direccion');
          print('_observacion=> $_observacion');
          print('_coordenadas=> $_coordenadas');
          final response = await _api.uptadeCliente(
              _id,
              _cedula,
              _nombre.toUpperCase(),
              _telefono,
              _correo,
              _direccion,
              _observacion,
              _coordenadas);
          //======= OCULTO PROGRES DIALOGO =====//
          ProgressDialog.dissmiss(context);
          if (response != null) {
            Navigator.pushReplacementNamed(context, 'homeSearchCliente');
          } else {
            String message = 'No se pudo Actualizar el Cliente';
            Dialogs.alert(
              context,
              title: 'ERROR',
              description: message,
            );
          }
        }
      }
    }

    final Responsive size = Responsive.of(context);

    return ChangeNotifierProvider<ClienteController>(
      create: (_) => ClienteController(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(color: btnSecundaryColor),
            title: Text('Editar Cliente'),
            actions: [
              FlatButton(
                splashColor: Colors.transparent,
                // splashRadius: 25.0,
                child: Icon(FontAwesomeIcons.save, color: Colors.white),
                onPressed: () {
                  _submit(context);
                },
              )
            ],
          ),
          body: Container(
            width: size.wp(100),
            height: size.hp(100),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _keyFormNuevoCliente,
                child: FutureBuilder(
                  future: _api.getCliente(_id),
                  builder:
                      (BuildContext context, AsyncSnapshot<Cliente> snapshot) {
                    final Responsive size = Responsive.of(context);
                    if (snapshot.hasData) {
                      final cliente = snapshot.data;
                      return formEditaCliente(size, context, cliente);
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

  Column formEditaCliente(
      Responsive size, BuildContext context, Cliente cliente) {
    return Column(
      children: [
        InputForm(
          size: size,
          label: 'Cédula',
          keyboardType: TextInputType.text,
          initialValue: cliente.cedula,
          readOnly: true,
          onSaved: (value) {
            _cedula = value;
            print(value);
          },
          validator: (text) {
            if (text.trim().length == 10 || text.trim().length == 13) {
              return null;
            } else {
              return 'Ingrese Cédula correcta';
            }
          },
        ),
        InputForm(
          size: size,
          keyboardType: TextInputType.text,
          label: 'Apellidos y Nombres',
          autofocus: true,
          initialValue: cliente.nombres,
          onSaved: (value) {
            _nombre = value;
            print(value);
          },
          // onChanged: (text) {
          //   _nombre = text;
          //   print(text);
          // },

          validator: (text) {
            if (text.trim().length > 0) {
              return null;
            } else {
              return 'Ingrese  apellidos y Nombre';
            }
          },
        ),
        InputForm(
          size: size,
          label: 'Celular',
          keyboardType: TextInputType.number,
          initialValue: cliente.celular,
          // onChanged: (text) {
          //   _telefono = text;
          //   print(text);
          // },
          onSaved: (value) {
            _telefono = value;
          },
          validator: (text) {
            if (text.trim().length > 0) {
              return null;
            } else {
              return 'Ingrese número de celular';
            }
          },
        ),
        InputForm(
          size: size,
          label: 'Correo',
          keyboardType: TextInputType.emailAddress,
          initialValue: cliente.email,
          // onChanged: (text) {
          //   _correo = text;
          //   print(text);
          // },
          onSaved: (value) {
            _correo = value;
          },
          validator: (text) {
            if (text.contains('@')) {
              return null;
            } else {
              return 'Correo inválido';
            }
          },
        ),
        InputForm(
          size: size,
          keyboardType: TextInputType.text,
          label: 'Dirección',
          initialValue: cliente.direccion,
          // onChanged: (text) {
          //   _direccion = text;
          //   print(text);
          // },
          onSaved: (value) {
            _direccion = value;
          },
          validator: (text) {
            if (text.trim().length > 0) {
              return null;
            } else {
              return 'Ingrese Dirección';
            }
          },
        ),
        InputForm(
          size: size,
          keyboardType: TextInputType.text,
          label: 'Observaciones',
          initialValue: cliente.observacion,
          // onChanged: (text) {
          //   _observacion = text;
          //   print(text);
          // },
          onSaved: (value) {
            _observacion = value;
          },
          validator: (text) {
            if (text.trim().length > 0) {
              return null;
            } else {
              return 'Ingrese Observaciones';
            }
          },
        ),
        Column(
          children: [
            // APELLIDO Y NOMBRE
            Container(
              width: size.wp(100),
              margin: EdgeInsets.only(top: size.dp(1.0), left: size.dp(1.0)),
              child: Text('Ubicación',
                  style: GoogleFonts.roboto(
                    fontSize: size.dp(1.7),
                    // fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.wp(3.0)),
              child: Consumer<ClienteController>(builder: (_, location, __) {
                return Text(
                    (location.position == null)
                        ? ' '
                        : '${location.position.latitude} -${location.position.longitude}',
                    style: GoogleFonts.roboto(
                      fontSize: size.dp(2.07),
                      // fontWeight: FontWeight.w500,
                      // color: Colors.black45,
                    ));
              }),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(
              horizontal: size.dp(10.0), vertical: size.dp(2.0)),
          width: size.wp(100),
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Obtener Ubicación',
                    style: GoogleFonts.roboto(
                      fontSize: size.dp(2.1),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
                    Icon(Icons.location_on_rounded,size: size.dp(4.0), color: Colors.white,)
              ],
            ),
            onPressed: () {
              getCoords(context);
              // Provider.of<CurrentGeolocator>(context, listen: false)
              //     .getCurrentPosition();
            },
          ),
        ),
      ],
    );
  }

  void getCoords(BuildContext context) async {
    ProgressDialog.show(context);
    await Provider.of<ClienteController>(context, listen: false)
        .getCurrentPosition();
    ProgressDialog.dissmiss(context);
  }
}

class InputForm extends StatelessWidget {
  final String label;
  final bool autofocus;
  final String data;
  final bool readOnly;
  final TextInputType keyboardType;
  final String initialValue;
  final void Function(String text) onChanged;
  final String Function(String) validator;
  final void Function(String) onSaved;

  const InputForm({
    Key key,
    @required this.size,
    @required this.label,
    this.data,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    // this.initialValue = "",
    this.onChanged,
    this.validator,
    this.initialValue,
    this.autofocus = false,
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
