class ExceptionValApi implements Exception {
  String cause;
  ExceptionValApi(this.cause);
}

class ExceptionPlayerNotInGame implements Exception {
  String cause;
  ExceptionPlayerNotInGame(this.cause);
}

class ExceptionTokenExpired implements Exception {
  String cause;
  ExceptionTokenExpired(this.cause);
}

class ExceptionPlayerNotFound implements Exception {
  String cause;
  ExceptionPlayerNotFound(this.cause);
}

class ExceptionTooManyRequests implements Exception {
  String cause;
  ExceptionTooManyRequests(this.cause);
}

class ExceptionFailedToGetCareer implements Exception {
  String cause;
  ExceptionFailedToGetCareer(this.cause);
}

class ExceptionRiotAPIConflict implements Exception {
  String cause;
  ExceptionRiotAPIConflict(this.cause);
}