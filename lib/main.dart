import 'package:flutter/material.dart';

import 'package:storePlace/src/routes/routes.dart';
import 'package:storePlace/src/utils/theme.dart';
// import 'package:storePlace/src/utils/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_)=>CurrentGeolocator()),
        //     ChangeNotifierProvider(create: (_)=>UserController()),
        //   ],
        //       child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STOREPLACE',
      theme: ThemeData(
        primaryColor: primaryColor,
        // accentColor: Color(0xFF3ED3D3),
        accentColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'splash',
      routes: appRoutes,
      // ),
    );
  }
}
