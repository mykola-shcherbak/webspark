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
      throw BadRequestException(jsonDecode(response.body)['message']);
    case 429:
      throw TooManyRequestsException(jsonDecode(response.body)['message']);
    case 500:
      throw InternalServerException(jsonDecode(response.body)['message']);
    default:
      throw FetchDataException(
          '${TextConstants.fetchError} ${response.statusCode}');
  }
}
