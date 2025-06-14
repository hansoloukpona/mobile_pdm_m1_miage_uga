import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/program_model.dart';
import '../models/program_to_search_request_model.dart';

class ProgramService {

  Future<List<Program>> searchPrograms(ProgramToSearchRequest criteria) async {
    final baseUrl = Uri.parse('http://localhost:8080');

    final response = await http.post(
      Uri.parse('$baseUrl/search/program'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(criteria.toJson()),
    );

    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      log(response.statusCode as String);
      return jsonList.map((json) => Program.fromJson(json)).toList();
    } else {
      throw Exception('Échec de la recherche');
    }
  }
}
