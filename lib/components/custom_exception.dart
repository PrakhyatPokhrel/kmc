class CustomException implements Exception {
  const CustomException({
    required this.message,
    this.statusCode = 0,
  });
  final String message;
  final int statusCode;
}
