import 'package:spark/constants/text_constants.dart';

class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, TextConstants.validationError, url);
}

class InternalServerException extends AppException {
  InternalServerException([String? message, String? url])
      : super(message, TextConstants.serverError, url);
}

class TooManyRequestsException extends AppException {
  TooManyRequestsException([String? message, String? url])
      : super(message, TextConstants.toManyRequestsError, url);
}

class FetchDataException extends AppException {
  FetchDataException(String fetchError, [String? message, String? url])
      : super(message, TextConstants.fetchError, url);
}

class ExeptionsHandlers {
  String getExeptionString(error) {
    print(error.toString());
    if (error is BadRequestException) {
      return findErrorMessage(error);
    } else if (error is InternalServerException) {
      return findErrorMessage(error);
    } else if (error is TooManyRequestsException) {
      return findErrorMessage(error);
    } else {
      return TextConstants.unknownError;
    }
  }

  String findErrorMessage(AppException error) {
    return (error.message == null || error.message == '')
        ? error.prefix.toString()
        : error.message.toString();
  }
}
