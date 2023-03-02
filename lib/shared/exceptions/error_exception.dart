class ErrorException implements Exception {
  String cause;
  ErrorException(this.cause);
}
