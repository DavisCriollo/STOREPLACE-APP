import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storePlace/src/screen/home/home_controller.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  const HomeAppBar({Key key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _searchEnabled = false;

  TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String text) {
    final controller = context.read<HomeController>();
    controller.onSearchTextChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _searchEnabled
          ? TextField(
              controller: _editingController,
              style: TextStyle(
                color: Colors.white,
              ),
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Buscar ...",
                hintStyle: TextStyle(color: Colors.white24),
              ),
              onChanged: _onSearchChanged,
            )
          : Text("Mis clientes"),
      actions: [
        IconButton(
          icon: Icon(_searchEnabled ? Icons.clear : Icons.search_rounded),
          onPressed: () {
            _searchEnabled = !_searchEnabled;
            if (!_searchEnabled) {
              _editingController.text = "";
              _onSearchChanged("");
            }
            setState(() {});
          },
        )
      ],
    );
  }
}
