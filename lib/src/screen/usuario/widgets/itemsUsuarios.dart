import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/data/models/usuariosAll.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/utils/theme.dart';

class ItemsUser extends StatelessWidget {
  const ItemsUser({
    Key key,
    @required this.size,
    @required this.usuario,
    @required this.api,
  }) : super(key: key);

  final Responsive size;
  final UsuarioAll usuario;
  final AutenticationProvider api;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: ListTile(
        dense: false,
        leading: Icon(
          Icons.person_pin_sharp,
          color: secondaryColor,
          size: size.dp(3.5),
        ),
        title: Text(
          usuario.nombres,
          style: GoogleFonts.roboto(
              fontSize: size.dp(1.6),
              color: Colors.black87,
              fontWeight: FontWeight.normal),
        ),
        subtitle: Text(usuario.email),
        trailing: Icon(
          Icons.chevron_right,
          size: size.dp(3.2),
          color: btnSecundaryColor,
        ),
        onTap: () {
          Navigator.pushNamed(context, 'infoUsuario', arguments: usuario);
        },
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
            key: Key(usuario.id),
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Confirmar'),
                  content: Text('Seguro de eliminar el registro ?'),
                  actions: [
                    FlatButton(
                      textColor: Colors.red,
                      onPressed: () {
                        api.deleteUsuario(usuario.id);
                        Navigator.pushReplacementNamed(
                            context, 'homeSearchCliente');
                      },
                      child: Text("OK"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(_);
                      },
                      child: Text("Cancel"),
                    )
                  ],
                ),
              );
            }
            //======= OCULTO PROGRES DIALOGO =====//
            ),
      ],
    );
  }
}
