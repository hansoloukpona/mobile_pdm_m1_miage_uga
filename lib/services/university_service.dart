import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../dtos/university_to_search_request_model.dart';
import '../models/university_model.dart';

class UniversityService {

  Future<List<University>> searchUniversities(UniversityToSearchRequest criteria) async {

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/search/university'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(criteria.toJson()),
    );

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => University.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      log(response.statusCode as String);
      return [];
    } else {
      log(response.statusCode as String);
      throw Exception('Échec de la recherche');
    }
  }
}
