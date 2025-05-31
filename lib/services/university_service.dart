import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/university_model.dart';
import '../models/university_to_search_request_model.dart';

class UniversityService {

  Future<List<University>> searchUniversities(UniversityToSearchRequest criteria) async {
    final baseUrl = Uri.parse('http://192.168.73.42:8080');

    final response = await http.post(
      Uri.parse('$baseUrl/search/university'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(criteria.toJson()),
    );

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => University.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      print('juste vide');
      return [];
    } else {
      print(response.statusCode);
      print('dgfgfgggfgdfhsghfgghhgjghjhgjhjjjk');
      throw Exception('Échec de la recherche');
    }
  }
}
