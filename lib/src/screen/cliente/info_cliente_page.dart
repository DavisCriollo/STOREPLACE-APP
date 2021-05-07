import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:storePlace/src/data/models/cliente.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/urls/urls.dart' as urls;
import 'package:storePlace/src/utils/theme.dart';

class DetalleClientePage extends StatefulWidget {
  @override
  _DetalleClientePageState createState() => _DetalleClientePageState();
}

class _DetalleClientePageState extends State<DetalleClientePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    final _api = AutenticationProvider();
    final String data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        //  iconTheme: IconThemeData(color: btnSecundaryColor),
        title: Text('Detalle del Cliente'),
        actions: [
          FlatButton(
            splashColor: Colors.transparent,
            // splashRadius: 25.0,
            child: Icon(
              FontAwesomeIcons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'editCliente', arguments: data);
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
          child: FutureBuilder(
            future: _api.getCliente(data),
            builder: (BuildContext context, AsyncSnapshot<Cliente> snapshot) {
              final Responsive size = Responsive.of(context);
              if (snapshot.hasData) {
                final cliente = snapshot.data;
                return infoCliente(size, context, cliente);
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
    );
  }

  Column infoCliente(Responsive size, BuildContext context, Cliente cliente) {
    return Column(
      children: [
        InputForm(size: size, label: 'Cédula', data: '${cliente.cedula}'
            // '156987454545',
            // data: '${clientetData.clientes.}',
            ),
        InputForm(
          size: size,
          label: 'Apellidos y Nombres',
          data: '${cliente.nombres}',
        ),
        InputForm(
          size: size,
          label: 'Teléfono',
          data: '${cliente.celular}',
        ),
        InputForm(
          size: size,
          label: 'Dirección',
          data: '${cliente.direccion}',
        ),
        InputForm(
          size: size,
          label: 'Observaciones',
          data: '${cliente.observacion}',
        ),
        Container(
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(
              // horizontal: size.dp(10.0),
              vertical: size.dp(1.0)),
          width: size.wp(35.0),
          child: FlatButton(
            child: Text('Visitar',
                style: GoogleFonts.roboto(
                  fontSize: size.dp(2.1),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                )),
            onPressed: () {
              bottomSheetMaps(
                context,
                size,
                cliente,
                'Navegar',
                'Seleccione Mapa',
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(
              // horizontal: size.dp(10.0),
              vertical: size.dp(1.0)),
          width: size.wp(35.0),
          child: FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Compartir',
                    style: GoogleFonts.roboto(
                      fontSize: size.dp(2.1),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
                Icon(
                  Icons.share,
                  color: Colors.white,
                )
              ],
            ),
            onPressed: () {
              _sharePosition(cliente);
            },
          ),
        )
      ],
    );
  }

  void _sharePosition(Cliente cliente) async {
    String title = 'Ubicación del Cliente: ${cliente.nombres}';
    final List<String> latlong = cliente.coordenadas.split(",");
    await Share.share(
        '$title, https://waze.com/ul?ll=${latlong[0]},${latlong[1]}&navigate=yes');
  }

  void bottomSheetMaps(BuildContext context, Responsive size, Cliente cliente,
      String title, String message) {
    double lat;
    double lng;

    final List<String> latlong = cliente.coordenadas.split(",");

    print('${cliente.coordenadas}');
    print('${latlong[0]}');
    print('${latlong[1]}');
    lat = double.parse(latlong[0]);
    lng = double.parse(latlong[1]);
    print('$lat');
    print('$lng');

    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              message: Text(message,
                  style: GoogleFonts.roboto(
                    fontSize: size.dp(2.0),
                    fontWeight: FontWeight.w500,
                    // color: Colors.white,
                  )),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    urls.launchWaze(lat, lng);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.wp(15.0),
                        child: Image.asset('assets/imgs/waze-icon.png'),
                      ),
                      Text('Waze Map'),
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    urls.launchGoogleMaps(lat, lng);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.wp(15.0),
                        child: Image.asset('assets/imgs/google-icon.png'),
                      ),
                      Text('Google Map'),
                    ],
                  ),
                ),
              ],
              // cancelButton: CupertinoActionSheetAction(
              //   onPressed: () => Navigator.of(context).pop(),
              //   child: Text('Close'),
              // ),
            ));
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
