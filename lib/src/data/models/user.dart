import 'package:meta/meta.dart' show required;




class User {
  final String id, email, name, lastname;
  final DateTime birhday;

  User(
  {  
    @required this.id,
    @required this.email,
    @required this.name,
    @required this.lastname,
    @required this.birhday,
  });
}
