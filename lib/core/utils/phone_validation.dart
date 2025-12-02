bool isMTN(String numero) {
  return RegExp(r'^(?:67|68|65[0-4])\d{6}$').hasMatch(numero);
}

bool isOrange(String numero) {
  return RegExp(r'^(?:69|65[5-9])\d{6}$').hasMatch(numero);
}