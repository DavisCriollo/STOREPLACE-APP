import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/screen/cliente/cliente_controller.dart';
// import 'package:storePlace/src/pages/clientes/clientes_controller.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/dialogs.dart';
import 'package:storePlace/src/utils/responsive.dart';

class FormCliente extends StatelessWidget {
  const FormCliente({
    Key key,
    @required this.size, @required this.keyFormNuevoCliente,
  }) : super(key: key);

  final GlobalKey<FormState> keyFormNuevoCliente;
  final Responsive size;

  @override
  Widget build(BuildContext context) {
  // final _keyFormNuevoCliente = GlobalKey<FormState>();
    final controller = Provider.of<ClienteController>(context, listen: false);
    return Container(
        // color: Colors.red,
        width: size.wp(100),
        height: size.hp(100),
        // margin: EdgeInsets.symmetric(horizontal: size.dp(0.5),vertical: size.dp(0.2)),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key:this.keyFormNuevoCliente ,
              child: Column(
            children: [
              InputForm(
                size: size,
                label: 'Cédula',
                keyboardType: TextInputType.text,
                // data: '156987454545',
                onChanged: (text) {
                  controller.onCedulaChange(text);
                  print(text);
                },
                validator: (text) {
                  if (text.trim().length ==10 ||text.trim().length ==13) {
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
                // data: 'JOSE LEONARDO MARTINEZ RODRIGUEZ',
                onChanged: (text) {
                  controller.onNombreChange(text);
                  print(text);
                },
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
                // data: '098756324',
                onChanged: (text) {
                  controller.onTelefonoChange(text);
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
              InputForm(
                size: size,
                label: 'Correo',
                keyboardType: TextInputType.emailAddress,
                // data: 'usuario@correo.com',
                onChanged: (text) {
                  controller.onCorreoChange(text);
                  print(text);
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
                // data: 'Av. Tsachilas N-51 entre rios y Durango',
                onChanged: (text) {
                  controller.onDireccionChange(text);
                  print(text);
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
                // data:
                // 'Casa esquinera frente a calzado Balderrama, segundo piso',
                onChanged: (text) {
                  controller.onObservacionesChange(text);
                  print(text);
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
                    margin:
                        EdgeInsets.only(top: size.dp(1.0), left: size.dp(1.0)),
                    child: Text('Ubicación',
                        style: GoogleFonts.roboto(
                          fontSize: size.dp(1.7),
                          // fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.wp(3.0)),
                    child:
                        Consumer<ClienteController>(builder: (_, location, __) {
                      return Text(location.selectCoords,
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
                    color: btnSecundaryColor,
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.symmetric(
                    horizontal: size.dp(10.0), vertical: size.dp(2.0)),
                width: size.wp(100),
                child: FlatButton(
                  child: Text('Obtener Ubicación',
                      style: GoogleFonts.roboto(
                        fontSize: size.dp(2.1),
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                  onPressed: () {
                    // controller.getCurrentPosition();
                    // getCoords(context);
                    // Provider.of<CurrentGeolocator>(context, listen: false)
                    //     .getCurrentPosition();
                    // _submil(context);
                    getCoords(controller,context) ;
                    
                  },
                ),
              ),
            ],
          )),
        ));
  }
  void getCoords  (ClienteController controller, BuildContext context)  async{
    ProgressDialog.show(context);
    await controller.getCurrentPosition();
    ProgressDialog.dissmiss(context);
  }
}

class InputForm extends StatelessWidget {
  final String label;
  final String data;
  final bool readOnly;
  final TextInputType keyboardType;
  // final String initialValue;
  final void Function(String text) onChanged;
  final String Function(String) validator;

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
            keyboardType: this.keyboardType,
            readOnly: this.readOnly,
            // initialValue: this.initialValue,
            textInputAction: TextInputAction.none,
            onChanged: this.onChanged,
            validator: this.validator,
            style: TextStyle(
                // letterSpacing: 2.0,
                // fontSize: size.dp(3.0),
                // fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
