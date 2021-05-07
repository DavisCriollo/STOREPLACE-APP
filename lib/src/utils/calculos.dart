import 'dart:math';

// class Calculos {
//   Calculos._internal();
//   static Calculos _instance = Calculos._internal();
//   static Calculos get instance => _instance;
//   }
// =======  REDONDEA NUMEROS A N DECIMALES =====//
double redondeaDouble(double value, int decimales) {
  double mod = pow(10.0, decimales);
  return ((value * mod).round().toDouble() / mod);
}

// =======  VALIDA SI EL DATO ES NUMERICO =====//
bool isNumeric(String value) {
  if (value.isEmpty) return false;
  final n = num.tryParse(value);
  if (n == null) {
    return false;
  } else {
    return true;
  }
}
