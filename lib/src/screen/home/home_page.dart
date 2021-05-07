import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/screen/home/home_controller.dart';
import 'package:storePlace/src/screen/home/widgets/home_app_bar.dart';

import '../../data/models/clientesAll.dart';
import '../../data/providers/autentication_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HomeController _controller;

  @override
  void initState() {
    super.initState();
    final authProvider = AutenticationProvider();
    _controller = HomeController(authProvider);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.init();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) => _controller,
      child: Scaffold(
        appBar: HomeAppBar(),
        drawer: Container(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Consumer<HomeController>(
            builder: (_, HomeController controller, __) {
              if (controller.error == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.error) {
                return Text("Error al cargar los datos");
              } else if (controller.clientes.isEmpty) {
                return Text("sin datos");
              }

              final List<ClienteAll> filteredList = controller.clientes.where(
                (element) {
                  return element.nombres.toLowerCase().contains(
                        controller.searchText.toLowerCase(),
                      );
                },
              ).toList();

              return ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (_, index) {
                  final client = filteredList[index];
                  return ListTile(
                    title: Text(client.email),
                    subtitle: Text(client.nombres),
                  );
                },
                itemCount: filteredList.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
