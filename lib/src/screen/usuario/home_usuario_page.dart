import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/data/models/searchUsuarios.dart';
import 'package:storePlace/src/data/models/session.dart';
import 'package:storePlace/src/data/models/usuariosAll.dart';
import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/data/providers/auth_storage.dart';
import 'package:storePlace/src/screen/usuario/search_controller.dart';
import 'package:storePlace/src/screen/usuario/widgets/itemsUsuarios.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/debouce_search.dart';
import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/utils/theme.dart';

import 'package:storePlace/src/widgets/bannerSinDatos.dart';

class UsuarioHomePage extends StatefulWidget {
  UsuarioHomePage({Key key}) : super(key: key);

  @override
  _UsuarioHomePageState createState() => _UsuarioHomePageState();
}

class _UsuarioHomePageState extends State<UsuarioHomePage> {
  Debounce debounce = Debounce(duration: Duration(milliseconds: 1500));
  @override
  void initState() {
    super.initState();
// VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chechLogin();
    });
  }

  @override
  void dispose() {
    debounce.cancel();
    super.dispose();
  }

  _chechLogin() async {
    final Session session = await Auth.instance.getSession();
    if (session == null) {
      Navigator.pushReplacementNamed(context, 'code');
    } else {}
  }

  final _api = AutenticationProvider();
  final controller = SearchController();
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return ChangeNotifierProvider<SearchController>(
        create: (_) => SearchController(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Consumer<SearchController>(
                builder: (_, provider, __) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: (provider.btnSearch)
                              ? Container(
                                  margin: EdgeInsets.only(right: size.dp(2.0)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.dp(0.5)),
                                  color: Colors.white,
                                  height: size.dp(4.0),
                                  width: size.wp(90.0),
                                  child: Center(
                                    child: TextField(
                                      autofocus: true,
                                      onChanged: (text) {
                                        debounce.create(() {
                                          controller.onSearchText(text);
                                          setState(() {});
                                        });
                                      },
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.search),
                                        border: InputBorder.none,
                                        hintText: 'Buscar usuario...',
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: size.wp(90.0),
                                  child: Text(
                                    'Mis Usuarios',
                                    style: GoogleFonts.roboto(
                                        fontSize: size.dp(2.8),
                                        // color: Colors.black87,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                        ),
                      ),
                      IconButton(
                          splashRadius: 2.0,
                          icon: (!provider.btnSearch)
                              ? Icon(
                                  Icons.search,
                                  size: size.dp(3.5),
                                )
                              : Icon(
                                  Icons.clear,
                                  size: size.dp(3.5),
                                ),
                          onPressed: () {
                            provider.setBtnSearch(!provider.btnSearch);
                          }),
                    ],
                  );
                },
              ),
              //
            ),
            body: Container(
              width: size.wp(100),
              height: size.hp(100),
              child: (controller.nameSearch.isNotEmpty)
                  ? FutureBuilder(
                      future: controller.searchUsuario(),
                      builder: (BuildContext context,
                          AsyncSnapshot<SearchUsuarios> snapshot) {
                        if (snapshot.hasData) {
                          return (snapshot.data.usuarios.length == 0)
                              ? FutureBuilder(
                                  future: _api.listarUsuarios(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<UsuariosAll> snapshot) {
                                    final Responsive size =
                                        Responsive.of(context);
                                    if (snapshot.hasData) {
                                      return (snapshot.data.usuarios.length ==
                                              0)
                                          ? BannerSinDatos(
                                              label: 'Usuario',
                                              size: size,
                                            )
                                          : ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount:
                                                  snapshot.data.usuarios.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final usuario = snapshot
                                                    .data.usuarios[index];
                                                return ItemsUser(
                                                  size: size,
                                                  usuario: usuario,
                                                  api: _api,
                                                );
                                              },
                                            );
                                    } else {
                                      return Container(
                                          height: size.hp(100.0),
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: size.dp(2.0)),
                                                child: Text(
                                                    'Preparando Información...'),
                                              ),
                                              CircularProgressIndicator(),
                                            ],
                                          )));
                                    }
                                  },
                                )

                              // BannerSearchSinDatos(
                              //     label: 'Usuario',
                              //     size: size,
                              //   )
                              : ListView.builder(
                                  itemCount: snapshot.data.usuarios.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final usuario =
                                        snapshot.data.usuarios[index];
                                    if (snapshot.hasData == null)
                                      return Text('NO HAY DATOS');
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
                                        subtitle: Text(
                                            '${usuario.email} - ${usuario.celular}'),
                                        trailing: Icon(
                                          Icons.chevron_right,
                                          size: size.dp(3.2),
                                          color: btnSecundaryColor,
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, 'infoUsuario',
                                              arguments: usuario.id);
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
                                                  content: Text(
                                                      'Seguro de eliminar el registro ?'),
                                                  actions: [
                                                    FlatButton(
                                                      textColor: Colors.red,
                                                      child: Text("OK"),
                                                      onPressed: () {
                                                        _api.deleteUsuario(
                                                            usuario.id);
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                'homeSearchCliente');
                                                      },
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
                                  },
                                );
                        } else {
                          return Container(
                              height: size.hp(100.0),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(bottom: size.dp(2.0)),
                                    child: Text('Buscando Información...'),
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              )));
                        }
                      },
                    )
                  : FutureBuilder(
                      future: _api.listarUsuarios(),
                      builder: (BuildContext context,
                          AsyncSnapshot<UsuariosAll> snapshot) {
                        final Responsive size = Responsive.of(context);
                        // if (snapshot.hasError) {
                        //   return Text(snapshot.hasError.toString());
                        // }
                        if (snapshot.hasData) {
                          return (snapshot.data.usuarios.length == 0)
                              ? BannerSinDatos(
                                  label: 'Usuario',
                                  size: size,
                                )
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.usuarios.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final usuario =
                                        snapshot.data.usuarios[index];
                                    return ItemsUser(
                                      size: size,
                                      usuario: usuario,
                                      api: _api,
                                    );
                                  },
                                );
                        } else {
                          return Container(
                              height: size.hp(100.0),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(bottom: size.dp(2.0)),
                                    child: Text('Preparando Información...'),
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              )));
                        }
                      },
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: secondaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'newUsuario');
              },
            ),
          );
        });
  }
}
