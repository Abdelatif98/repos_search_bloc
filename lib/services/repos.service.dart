import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:repos_search_bloc/model/RS/repoRS.dart';
import 'package:repos_search_bloc/model/repository.model.dart';

class ReposService {
  static final HttpClient _httpClient = HttpClient();
  String _url = 'https://api.github.com';

  Future<List<Repository>> getRepositories() async {
    ReposRS result = new ReposRS();
    final date = DateTime(DateTime.now().year, DateTime.now().month-1 , DateTime.now().day);
    final formattedDate = formatDate(date, [yyyy, '-', mm, '-', dd]);

    final uri = Uri.https(_url, '/search/repositories', {
      'q': 'created:>$formattedDate',
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '20'
    });

    final response = await http
        .get(uri);
    if (response.statusCode == 200 || json != null) {
      Map jsonParsed = json.decode(response.body);
      result = ReposRS.fromJson(jsonParsed);
      return result.items;
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to load post');
    }
  }
}