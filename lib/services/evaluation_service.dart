import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:selectivite/dtos/evaluation_to_create_request_model.dart';
import 'package:selectivite/models/evaluation_model.dart';

import '../config/api_config.dart';
import '../dtos/program_to_search_request_model.dart';
import '../models/program_model.dart';

class EvaluationService {

  Future<List<Evaluation>> getAllEvaluationsByProgram(String programId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/ton-backend/api/evaluations/program/$programId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Evaluation.fromJson(e)).toList();
    } else {
      throw Exception('Échec du chargement des évaluations (code ${response.statusCode})');
    }
  }

  Future<Evaluation> addEvaluation(EvaluationToCreateRequest evaluationToCreate) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/ton-backend/api/evaluations'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(evaluationToCreate.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Evaluation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Échec de l\'ajout de l\'évaluation (code ${response.statusCode})');
    }
  }

/*List<Program> filterEvaluation(String query, List<Evaluation> evaluations) {
    return evaluations.where((evaluation) =>
        evaluation.tag.name.toLowerCase().contains(query.toLowerCase())).toList();
  }*/

}
