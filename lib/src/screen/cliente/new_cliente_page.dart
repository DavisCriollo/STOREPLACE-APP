import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
// import 'package:storePlace/src/pages/clientes/clientes_controller.dart';

import 'package:storePlace/src/screen/cliente/cliente_controller.dart';
import 'package:storePlace/src/utils/dialogs.dart';

import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/widgets/formCliente.dart';

class PageNewCliente extends StatelessWidget {
  final keyFormNuevoCliente = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return ChangeNotifierProvider<ClienteController>(
        create: (_) => ClienteController(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              // iconTheme: IconThemeData(color: btnSecundaryColor),
              title: Text('Nuevo Cliente'),
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
            body: FormCliente(
                size: size, keyFormNuevoCliente: keyFormNuevoCliente),
          );
        });
  }

  void _submit(BuildContext context) async {
    final controller = context.read<ClienteController>();
    if (controller.selectCoords == "") {
      Dialogs.alert(
        context,
        title: 'SIN COORDENADAS',
        description: 'Debe obtener la Ubicación del cliente',
      );
    } else {
      final isOk = keyFormNuevoCliente.currentState.validate();
      if (isOk) {
        final data = await controller.nuevoCliente();
        if (data == true) {
          Navigator.pushReplacementNamed(context, 'homeSearchCliente');
        } else {
          Dialogs.alert(
            context,
            title: 'ERROR',
            description: 'No se pudo registral al cliente',
          );
        }
      }
    }
  }
}
// }
