abstract class CustomRegexPattern {
  static final nepaliInputWithoutSlash = RegExp("[\u0900-\u097F ]+");
  static final nepaliInput = RegExp("[\u0900-\u097F-/ ]+");
  static final excludeNepaliInput = RegExp(r'^(?:(?![\u0900-\u097F]).)+$');
  static final number = RegExp("[0-9]+");
  static final email =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final date = RegExp(r'^[०-९]{4}/[०-९]{2}/[०-९]{2}$');
  static final englishInput = RegExp('[a-zA-Z0-9@ \-\/]+');
}
