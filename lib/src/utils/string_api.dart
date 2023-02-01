extension Validator on String {
  bool get isValidPassword => trim().length >= 6;
}
