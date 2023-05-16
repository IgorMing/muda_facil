class Validators {
  static bool hasSpaceBetween(String value) =>
      RegExp(r'(\s+)').hasMatch(value.trim());
}
