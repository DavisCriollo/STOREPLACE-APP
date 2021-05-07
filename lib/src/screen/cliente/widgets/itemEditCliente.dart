import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/data/models/clientesAll.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';

class ItemEditClientes extends StatelessWidget {
  const ItemEditClientes({
    Key key,
    @required this.size,
    @required this.cliente,
    @required this.api,
  }) : super(key: key);

  final Responsive size;
  final ClienteAll cliente;
  final AutenticationProvider api;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: ListTile(
        dense: false,
        leading: Icon(
          Icons.place,
          color: btnSecundaryColor,
          size: size.dp(3.5),
        ),
        title: Text(
          cliente.nombres,
          style: GoogleFonts.roboto(
              fontSize: size.dp(1.6),
              color: Colors.black87,
              fontWeight: FontWeight.normal),
        ),
        subtitle: Text('${cliente.email} - ${cliente.celular}'),
        trailing: Icon(
          Icons.chevron_right,
          size: size.dp(3.2),
          color: btnSecundaryColor,
        ),
        onTap: () {
          Navigator.pushNamed(context, 'infoCliente', arguments: cliente.id);
        },
      ),
      //     actions: <Widget>[
      //   IconSlideAction(
      //     caption: 'Archive',
      //     color: Colors.blue,
      //     icon: Icons.archive,
      //     // onTap: () => _showSnackBar('Archive'),
      //     onTap: (){},
      //   ),
      //   IconSlideAction(
      //     caption: 'Share',
      //     color: Colors.indigo,
      //     icon: Icons.share,
      //     onTap: (){},
      //   ),
      // ],
      secondaryActions: <Widget>[
        // IconSlideAction(
        //   caption: 'More',
        //   color: Colors.black45,
        //   icon: Icons.more_horiz,
        //   onTap: (){},
        // ),
        IconSlideAction(
            key: Key(cliente.id),
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
                        api.deleteCliente(cliente.id);
                        Navigator.pushReplacementNamed(context, 'home');
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
