// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:storePlace/src/utils/colors.dart';
// import 'package:storePlace/src/utils/responsive.dart';
// import 'package:storePlace/src/urls/urls.dart' as urls;

// class Dialogs {
//   static info(BuildContext context, {String title, String content}) {
//     showDialog(
//       context: context,
//       builder: (_) => CupertinoAlertDialog(
//         title: title != null ? Text(title) : null,
//         content: content != null ? Text(content) : null,
//         actions: <Widget>[
//           CupertinoDialogAction(
//             child: Text("OK"),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Confirmacion {
//   static info(BuildContext context, {String title, String content}) {
//     showDialog(
//       context: context,
//       builder: (_) => CupertinoAlertDialog(
//         title: title != null ? Text(title) : null,
//         content: content != null ? Text(content) : null,
//         actions: <Widget>[
//           CupertinoDialogAction(
//             child: Text("OK"),
//             onPressed: () {
//               // Navigator.pop(context);
//               Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// abstract class ProgressDialog {
//   final BuildContext context;
//   ProgressDialog(this.context);
//   void show() {
//     showCupertinoModalPopup(
//       context: this.context,
//       builder: (_) => WillPopScope(
//         onWillPop: () async {
//           return false;
//         },
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           color:Color.fromRGBO(153, 153, 153, 0.72),
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       ),
//     );
//   }

//   void dismisDialog() {
//     Navigator.pop(context);
//   }
// }

// class Botons {
//   static bottomSheetMaps(BuildContext context, Responsive size,double lat, double lng,
//       {String title, String message}) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (_) => CupertinoActionSheet(
//         // title: title != null
//         //     ? Text(title,
//         //         style: GoogleFonts.roboto(
//         //           fontSize: size.iScreen(2.1),
//         //           fontWeight: FontWeight.w500,
//         //           color: primaryColor,
//         //         ))
//         //     : null,
//         message: message != null
//             ? Text(message,
//                 style: GoogleFonts.roboto(
//                   fontSize: size.dp(2.0),
//                   fontWeight: FontWeight.w500,
//                   color: primaryColor,
//                 ))
//             : null,
//         actions: [
//           CupertinoActionSheetAction(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: size.dp(7.0),
//                   child: Image.asset(
//                     'assets/imgs/waze-icon.png',
//                   ),
//                 ),
//                 Container(
//                   child: Text('Waze Maps'),
//                 ),
//               ],
//             ),
//             onPressed: () {
//                urls.launchWaze(lat, lng);
//               Navigator.pop(context);
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: size.dp(7.0),
//                   child: Image.asset(
//                     'assets/imgs/google-icon.png',
//                   ),
//                 ),
//                 Container(
//                   child: Text('Google Maps'),
//                 ),
//               ],
//             ),
//             onPressed: () {
//               urls.launchGoogleMaps(lat, lng);
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     );
//       }}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  static alert(
    BuildContext context, {
    @required String title,
    @required String description,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(_);
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }
}

abstract class ProgressDialog {
  static show(BuildContext context, {String messaje}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.9),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          onWillPop: () async => false,
        );
      },
    );
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }
}
