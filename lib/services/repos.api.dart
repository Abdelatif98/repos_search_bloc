import 'package:date_format/date_format.dart';
import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:async';
import 'package:repos_search_bloc/model/repo.dart';

class Api {
  static final HttpClient _httpClient = HttpClient();
  static final String _url = "api.github.com";

  static Future<List<Repo>> getRepositories(int page) async {
    final date = DateTime(DateTime.now().year, DateTime.now().month , DateTime.now().day-1);
    final formattedDate = formatDate(date, [yyyy, '-', mm, '-', dd]);

    final uri = Uri.https(_url, '/search/repositories', {
      'q': 'created:>$formattedDate',
      'sort': 'stars',
      'order': 'desc',
      'page': '$page',
      'per_page': '20'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != 200) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}