import 'package:flutter/material.dart';
import 'package:storePlace/src/screen/home/home_page.dart';
import 'package:storePlace/src/screen/info/acercaDe_page.dart';
import 'package:storePlace/src/screen/cliente/edit_cliente_page.dart';
import 'package:storePlace/src/screen/cliente/home_cliente_page.dart';
import 'package:storePlace/src/screen/cliente/info_cliente_page.dart';
import 'package:storePlace/src/screen/cliente/new_cliente_page.dart';
import 'package:storePlace/src/screen/info/contactos_page.dart';
import 'package:storePlace/src/screen/loginCode/code_page.dart';
import 'package:storePlace/src/screen/miPerfil/editar_perfil_page.dart';
import 'package:storePlace/src/screen/splash_page.dart';
import 'package:storePlace/src/screen/usuario/editar_usuario_page.dart';
import 'package:storePlace/src/screen/usuario/home_usuario_page.dart';
import 'package:storePlace/src/screen/usuario/info_usuario_page.dart';
import 'package:storePlace/src/screen/miPerfil/mi_perfil_page.dart';
import 'package:storePlace/src/screen/usuario/nuevo_usuario_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'splash': (_) => SplashPage(),
  'code': (_) => CodePage(),
  'newCliente': (_) => PageNewCliente(),
  'infoCliente': (_) => DetalleClientePage(),
  'editCliente': (_) => EditarClientePage(),
  'newUsuario': (_) => NuevoUsuarioPage(),
  'infoUsuario': (_) => DetalleUsuarioPage(),
  'editUsuario': (_) => EditUsuarioPage(),
  'homeSearchCliente': (_) => ClienteHomePage(),
  'homeSearchUsuario': (_) => UsuarioHomePage(),
  'miPerfil': (_) => MiPerfilPage(),
  'editPerfil': (_) => EditPerfilPage(),
  'acercade': (_) => AcercaDePage(),
  'contactenos': (_) => CantactosPage(),
  'home': (_) => HomePage(),
};
