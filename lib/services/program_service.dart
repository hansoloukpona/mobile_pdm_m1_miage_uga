import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/program_model.dart';
import '../models/program_to_search_request_model.dart';

class ProgramService {

  Future<List<Program>> searchPrograms(ProgramToSearchRequest criteria) async {
    final baseUrl = Uri.parse('http://localhost:8080');

    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/search/program'),
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

  Future<List<Program>> getallByUniversityId(ProgramToSearchRequest criteria) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/search/program/by_university'),
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


  List<Program> filterFilieres(String query, List<Program> programs) {
    return programs.where((filiere) =>
        filiere.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

}
