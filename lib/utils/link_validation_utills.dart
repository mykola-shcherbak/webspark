import 'package:spark/api/task_api.dart';

bool validateLink(String link) {
  bool isQuerryparams = link.startsWith('${TaskApiClient.baseUrl}?');
  bool isAbsolute = Uri.parse(link).isAbsolute;
  bool isInitial = link == TaskApiClient.baseUrl;
  bool isValid = (isQuerryparams || isInitial) && isAbsolute;
  return isValid;
}
