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
    if (error is BadRequestException) {
      return findExceptionMessage(error);
    } else if (error is InternalServerException) {
      return findExceptionMessage(error);
    } else if (error is TooManyRequestsException) {
      return findExceptionMessage(error);
    } else {
      return TextConstants.unknownError;
    }
  }

  String findExceptionMessage(AppException error) {
    if (error.message != '') {
      return error.message.toString();
    } else {
      return error.prefix.toString();
    }
  }
}
