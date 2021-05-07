import 'package:storePlace/src/data/models/codeLogin.dart';


abstract class AuthenticationRepository {
  Future<CodeLogin> loginCode(String code);
}

