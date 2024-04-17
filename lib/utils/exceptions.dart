class ExceptionValApi implements Exception {
  String cause;
  ExceptionValApi(this.cause);
}

class ExceptionPlayerNotInGame implements Exception {
  String cause;
  ExceptionPlayerNotInGame(this.cause);
}