// import 'package:dio/dio.dart';

// import 'package:get_it/get_it.dart';
// import 'package:logger/logger.dart';
// import 'package:storePlace/src/data/providers/autentication_provider.dart';
// import 'package:storePlace/src/helpers/http.dart';

// abstract class DependencyInjection {
//   static void initialize() {
//     final Dio dio = Dio(
//       BaseOptions(baseUrl: 'https://storeplace.gerverd.com/api'),
//     );
//     Logger logger = Logger();
//     Http http = Http(
//       dio: dio,
//       logger: logger,
//       logsEnabled: true,
//     );

//     final authenticationAPI = AutenticationProvider(http);
//     GetIt.instance.registerSingleton<AutenticationProvider>(authenticationAPI);

// //     //   final secureStorage = FlutterSecureStorage();

// //     //   final authenticationClient = AuthenticationClient(secureStorage, authenticationAPI);
// //     //   final accountAPI = AccountAPI(http, authenticationClient);

// //     //   GetIt.instance.registerSingleton<AuthenticationClient>(authenticationClient);
// //     //   GetIt.instance.registerSingleton<AccountAPI>(accountAPI);
// //     // }
//   }
// }
