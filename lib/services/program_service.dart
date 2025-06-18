import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../dtos/program_to_display_model.dart';
import '../dtos/program_to_search_request_model.dart';
import '../models/program_model.dart';

class ProgramService {

  Future<List<Program>> searchPrograms(ProgramToSearchRequest criteria) async {
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

  List<Program> filterFilieres(String query, List<Program> programs) {
    return programs.where((filiere) =>
        filiere.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  Future<ProgramToDisplay> getProgramDetails(String programId) async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/programs/$programId'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ProgramToDisplay.fromJson(jsonData);
    } else {
      throw Exception('Erreur lors de la récupération du programme : ${response.statusCode}');
    }
  }

}
