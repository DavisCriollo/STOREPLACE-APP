// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart' as Geolocator;

// class CurrentGeolocator extends ChangeNotifier {
//   Geolocator.Position _position;
//   Geolocator.Position get position => this._position;
//   String _selectCoords="";
//   String get selectCoords=>_selectCoords;

//   void getCurrentPosition() async {
//     this._position =
//         await Geolocator.GeolocatorPlatform.instance.getCurrentPosition(
//       desiredAccuracy: Geolocator.LocationAccuracy.bestForNavigation,
//     );
//     _position = position;
//     _selectCoords=('${position.latitude},${position.longitude}');
//     notifyListeners();
//   }
// }
