import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storePlace/src/data/models/session.dart';

import 'package:storePlace/src/data/providers/auth_storage.dart';

import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/utils/theme.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    @required this.size,
  });

  final Responsive size;

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  // final controller = ClienteController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: widget.size.dp(10.0)),
                padding: EdgeInsets.only(bottom: widget.size.dp(3.0)),
                child: Center(
                  child: Text(
                    'Menu',
                    style: GoogleFonts.roboto(
                      fontSize: widget.size.dp(3.2),
                      fontWeight: FontWeight.bold,
                      // color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _ListaOpciones(
                    // user: _user,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  // final String user;

  const _ListaOpciones({
    Key key,
    //  @required this.user
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);

    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
//=================================================================//
        Column(
          children: [
            ListTile(
              dense: true,
              leading: Icon(
                FontAwesomeIcons.userAlt,
                color: secondaryColor,
              ),
              title: Text(
                'Mi Perfil',
                style: GoogleFonts.roboto(
                  fontSize: size.dp(2.2),
                  // color: Colors.white,
                ),
              ),
              trailing: FaIcon(
                FontAwesomeIcons.chevronRight,
                color: btnSecundaryColor,
                size: size.dp(2.2),
              ),
              onTap: () async {
                final Session session = await Auth.instance.getSession();
                if (session != null) {
                  print('ID USUARIO DRAWER: ${session.id}');
                  Navigator.pushNamed(context, 'miPerfil',
                      arguments: session.id);
                }
              },
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),

//==============================================================//
        // _ItemsMenu(
        //     icon: FontAwesomeIcons.userAlt,
        //     title: 'Mi Perfil',
        //     page: 'miPerfil',
        //     size: size),
        //======== AGREGAMOS MENU PARA ADMINISTRADOR =======//

        _ItemsMenu(
            icon: FontAwesomeIcons.userFriends,
            title: 'Mis Usuarios',
            page: 'homeSearchUsuario',
            size: size),

        //======== COMPARTIR APP =======//
        ListTile(
            enabled: true,
            dense: true,
            leading: Icon(
              FontAwesomeIcons.shareAlt,
              color: secondaryColor,
            ),
            title: Text('Compartir',
                style: GoogleFonts.roboto(
                  fontSize: size.dp(2.2),
                  // color: Colors.white,
                )),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: btnSecundaryColor,
              size: size.dp(2.2),
            ),
            onTap: () {
              // context.read<HomeController>().shareApp();
            }),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
        // ======================================//
        _ItemsMenu(
            icon: FontAwesomeIcons.headset,
            title: 'Contáctenos',
            page: 'contactenos',
            size: size),
        _ItemsMenu(
            icon: FontAwesomeIcons.laptopCode,
            title: 'Acerca de',
            page: 'acercade',
            size: size),
        ListTile(
          title: Text(
            'Cerrar Sesión',
            style: GoogleFonts.roboto(
              fontSize: size.dp(2.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: secondaryColor,
          ),
          onTap: () async {
            await Auth.instance.logOut(context);
            // await context.read<HomeController>().signOut();
            Navigator.pushNamedAndRemoveUntil(
                context, 'code', (route) => false);
          },
        ),
      ],
    );
  }

// _menuAdmin(Responsive size)
// {
//    Column(
//      children: [
//        _ItemsMenu(
//                 icon: FontAwesomeIcons.userAlt,
//                 title: 'Mi Usuarios',
//                 page: 'usuarios',
//                 size: size),
//        _ItemsMenu(
//                 icon: FontAwesomeIcons.userAlt,
//                 title: 'Mis Clientes',
//                 page: 'clientes',
//                 size: size),

//      ],
//    );
// }

}

class _ItemsMenu extends StatelessWidget {
  final Responsive size;

  final String title;
  final IconData icon;
  final String page;
  final bool enable;
  _ItemsMenu({
    @required this.title,
    @required this.icon,
    this.page,
    @required this.size,
    this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: Icon(
            this.icon,
            color: secondaryColor,
          ),
          title: Text(
            this.title,
            style: GoogleFonts.roboto(
              fontSize: size.dp(2.2),
              // color: Colors.white,
            ),
          ),
          trailing: FaIcon(
            FontAwesomeIcons.chevronRight,
            color: btnSecundaryColor,
            size: size.dp(2.2),
          ),
          onTap: () {
            Navigator.popAndPushNamed(context, this.page);
            // share();
          },
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
