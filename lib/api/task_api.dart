import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spark/api/exeptions_handlers.dart';
import 'package:spark/constants/text_constants.dart';

class TaskApiClient {
  static const String baseUrl = 'https://flutter.webspark.dev/flutter/api';

  Future<dynamic> getTasks(String link) async {
    final uri = Uri.parse(baseUrl);

    try {
      final http.Response response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return processResponce(response);
    } catch (e) {
      throw ExeptionsHandlers().getExeptionString(e);
    }
  }

  Future<void> postSolutions(List<dynamic> solutions) async {
    final Uri url = Uri.parse(baseUrl);
    try {
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(solutions),
      );
      processResponce(response);
    } catch (e) {
      throw ExeptionsHandlers().getExeptionString(e);
    }
  }
}

dynamic processResponce(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return json.decode(response.body)['data'];
    case 400:
      throw BadRequestException(findRespoMessage(jsonDecode(response.body)));
    case 429:
      throw TooManyRequestsException(
          findRespoMessage(jsonDecode(response.body)));
    case 500:
      throw InternalServerException(
          findRespoMessage(jsonDecode(response.body)));
    default:
      throw FetchDataException(
          '${TextConstants.fetchError} ${response.statusCode}');
  }
}

String findRespoMessage(body) {
  if (body['message'] != null && body['message'] != '') {
    return body.message.toString();
  } else if (body['data']['message'] != null && body['data']['message'] != '') {
    return body['data']['message'].toString();
  }
  return '';
}
