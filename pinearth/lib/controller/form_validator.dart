class Validator {
  static String? validateEmptyField(String? str) {
    if (str == null || str.trim().isEmpty) {
      return "Field cannot be empty";
    } else {
      return null;
    }
  }
}
