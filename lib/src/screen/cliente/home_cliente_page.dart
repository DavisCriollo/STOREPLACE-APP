import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/data/models/clientesAll.dart';
import 'package:storePlace/src/data/models/searchClientes.dart';
import 'package:storePlace/src/data/models/session.dart';
import 'package:storePlace/src/data/providers/api_provider.dart';

import 'package:storePlace/src/data/providers/autentication_provider.dart';
import 'package:storePlace/src/data/providers/auth_storage.dart';
import 'package:storePlace/src/helpers/api_response.dart';
import 'package:storePlace/src/helpers/http.dart';
import 'package:storePlace/src/helpers/http_client.dart';
import 'package:storePlace/src/screen/cliente/cliente_controller.dart';
import 'package:storePlace/src/screen/cliente/search_cliente_controller.dart';
import 'package:storePlace/src/screen/cliente/widgets/itemsCliente.dart';
import 'package:storePlace/src/utils/colors.dart';
import 'package:storePlace/src/utils/debouce_search.dart';
import 'package:storePlace/src/utils/responsive.dart';
import 'package:storePlace/src/utils/theme.dart';

import 'package:storePlace/src/widgets/bannerSinDatos.dart';
import 'package:storePlace/src/widgets/drawer.dart';

class ClienteHomePage extends StatefulWidget {
  ClienteHomePage({Key key}) : super(key: key);

  @override
  _ClienteHomePageState createState() => _ClienteHomePageState();
}

class _ClienteHomePageState extends State<ClienteHomePage> {
  Debounce debounce = Debounce(duration: Duration(milliseconds: 1500));

  final controllerCliente = ClienteController();
  @override
  void initState() {
    super.initState();
// VERIFICO SI EL CONTEXTO  ESTA INICIALIZADO//
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chechLogin();
      loadingPage();
    });
  }

  _chechLogin() async {
    final _api = ApiProvider(httpClient);
    _api.getCliente();

    final Session session = await Auth.instance.getSession();
    if (session == null) {
      Navigator.pushReplacementNamed(context, 'code');
    }
  }

  void loadingPage() {
    setState(() {});
  }

  @override
  void dispose() {
    debounce.cancel();
    super.dispose();
  }

  final _api = AutenticationProvider();
  final controller = SearchClienteController();
  @override
  Widget build(BuildContext context) {
    final Responsive size = Responsive.of(context);
    return ChangeNotifierProvider<SearchClienteController>(
        create: (_) => SearchClienteController(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: Consumer<SearchClienteController>(
                builder: (_, provider, __) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: (provider.btnSearch)
                              ? Container(
                                  margin: EdgeInsets.only(right: size.dp(2.0)),
                                  padding: EdgeInsets.symmetric(horizontal: size.dp(0.5)),
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
                                        hintText: 'Buscar cliente...',
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: size.wp(90.0),
                                  child: Text(
                                    'Mis Clientes',
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
                            setState(() {});
                          }),
                    ],
                  );
                },
              ),
            ),
            //============================//
            drawer: Drawer(
                child: MenuDrawer(
              size: size,
            ) // Populate the Drawer in the next step.
                ),
            //============================//
            body: Container(
              width: size.wp(100),
              height: size.hp(100),
              child: (controller.nameSearch.isNotEmpty)
                  ? FutureBuilder(
                      future: controller.searchClientesAll(),
                      builder: (BuildContext context, AsyncSnapshot<SearchClientes> snapshot) {
                        if (snapshot.hasData) {
                          return (snapshot.data.clientes.length == 0)
                              ? FutureBuilder(
                                  future: _api.listarClientes(),
                                  builder: (BuildContext context, AsyncSnapshot<ApiResponse<Clientes>> snapshot) {
                                    final Responsive size = Responsive.of(context);

                                    if (snapshot.hasData) {
                                      return (snapshot.data.data.clientes.length == 0)
                                          ? BannerSinDatos(
                                              label: 'Clientes',
                                              size: size,
                                            )
                                          : ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: snapshot.data.data.clientes.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                final cliente = snapshot.data.data.clientes[index];
                                                return ItemClientes(
                                                  size: size,
                                                  cliente: cliente,
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
                                                margin: EdgeInsets.only(bottom: size.dp(2.0)),
                                                child: Text('Preparando Información...'),
                                              ),
                                              CircularProgressIndicator(),
                                            ],
                                          )));
                                    }
                                  },
                                )

                              //  BannerSearchSinDatos(
                              //     label: 'Clientes',
                              //     size: size,
                              //   )
                              : ListView.builder(
                                  itemCount: snapshot.data.clientes.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final cliente = snapshot.data.clientes[index];
                                    if (snapshot.hasData == null) return Text('NO HAY DATOS');
                                    return Slidable(
                                      actionPane: SlidableDrawerActionPane(),
                                      child: ListTile(
                                        dense: false,
                                        leading: Icon(
                                          Icons.place,
                                          color: secondaryColor,
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
                                      secondaryActions: <Widget>[
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
                                                        _api.deleteCliente(cliente.id);
                                                        Navigator.pushReplacementNamed(context, 'homeSearchCliente');
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
                                  },
                                );
                        }
                        return Container(
                            height: size.hp(100.0),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: size.dp(2.0)),
                                  child: Text('Buscando Información...'),
                                ),
                                CircularProgressIndicator(),
                              ],
                            )));
                      },
                    )
                  : FutureBuilder(
                      future: _api.listarClientes(),
                      builder: (BuildContext context, AsyncSnapshot<ApiResponse<Clientes>> snapshot) {
                        final Responsive size = Responsive.of(context);
                        if (snapshot.hasData) {
                          return (snapshot.data.data.clientes.length == 0)
                              ? BannerSinDatos(
                                  label: 'Clientes',
                                  size: size,
                                )
                              : ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.data.clientes.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final cliente = snapshot.data.data.clientes[index];
                                    return ItemClientes(
                                      size: size,
                                      cliente: cliente,
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: secondaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'newCliente');
              },
            ),
          );
        });
  }
}
