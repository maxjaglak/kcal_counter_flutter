class AppException implements Exception {

  final AppError error;
  final String? message;

  AppException(this.error, {this.message});

  @override
  String toString() {
    return 'AppException{error: $error, message: $message}';
  }

}

enum AppError {
  GENERAL_ERROR,

  //csv
  INPUT_FILE_NOT_A_CSV,
  INVALID_CSV_FILE,

}

extension AppErrorTranslationKey on AppError {
  String getMessage() {
    switch(this) {
      case AppError.GENERAL_ERROR: return "Wystąpił błąd";
      case AppError.INPUT_FILE_NOT_A_CSV: return "Plik nie jest plikiem CSV";
      case AppError.INVALID_CSV_FILE: return "Niepoprawny plik CSV - sprawdź instrukcje jak stworzyć plik CSV";
    }

    return "Wystąpił błąd";
  }
}
