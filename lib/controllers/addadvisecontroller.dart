import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:selectivite/config/api_config.dart';
import 'package:selectivite/dtos/evaluation_to_create_request_model.dart';
import 'package:selectivite/services/evaluation_service.dart';

import '../models/evaluation_model.dart';

class AddAdviseController extends ChangeNotifier {
  final EvaluationService _evaluationService = EvaluationService();

  bool isLoading = false;

  // Déclaration des TextEditingController
  //final TextEditingController nameController = TextEditingController();

  final TextEditingController commentController = TextEditingController();
  final TextEditingController studyYearController = TextEditingController();
  int studyYear = DateTime.now().year;
  bool hasDroppedOut = false;

  Map<String, int> ratings = {
    'Selectivity': 0,
    'Quality of Education': 0,
    'Academic Rigor': 0,
    'Supervision': 0,
    'Satisfaction': 0,
  };

  @override
  void dispose() {
    // Libérer les contrôleurs pour éviter les fuites de mémoire
    commentController.dispose();
    studyYearController.dispose();

    super.dispose();
  }

  Future<void> addEvaluation(String programId) async {
    final evaluationToCreate = EvaluationToCreateRequest(
      programId: programId,
      studyYear: studyYear,
      submissionYear: DateTime.now().year,
      selectivityScore: ratings['Selectivity']!,
      qualityScore: ratings['Quality of Education']!,
      rigorScore: ratings['Academic Rigor']!,
      supervisionScore: ratings['Supervision']!,
      satisfactionScore: ratings['Satisfaction']!,
      hasDroppedOut: hasDroppedOut,
      comment: commentController.text.isEmpty ? null : commentController.text,
      isAnonymous: true, //TODO Vérifer la connexion de l'utilisation ici
    );
    //await _evaluationService.addEvaluation(evaluationToCreate);
    
    Evaluation evaluationForJson = Evaluation(id: DateTime.now().millisecondsSinceEpoch.toString(), userId: evaluationToCreate.userId, programId: evaluationToCreate.programId, studyYear: evaluationToCreate.studyYear, submissionYear: evaluationToCreate.submissionYear, selectivityScore: evaluationToCreate.selectivityScore, qualityScore: evaluationToCreate.qualityScore, rigorScore: evaluationToCreate.rigorScore, supervisionScore: evaluationToCreate.supervisionScore, satisfactionScore: evaluationToCreate.satisfactionScore, comment: evaluationToCreate.comment, submittedAt: DateTime.now(), updatedAt: null, isAnonymous: evaluationToCreate.isAnonymous);
    await addEvaluation2(evaluationForJson);

  }

  Future<List<Evaluation>> readEvaluationsByProgramId(String programId) async {
    try {
      isLoading = true;

      final file = await _getLocalFile();
      if (!await file.exists()) return [];

      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);

      return jsonData
          .map((e) => Evaluation.fromJson(e))
          .where((e) => e.programId == programId)
          .toList();
    } catch (e) {
      log("Erreur lecture évaluations par programme : $e");
      return [];
    }
  }


  Future<List<Evaluation>> readEvaluations() async {
    try {
      final file = await _getLocalFile();
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((e) => Evaluation.fromJson(e)).toList();
    } catch (e) {
      log("Erreur lecture fichier : $e");
      return [];
    }
  }

  Future<void> addEvaluation2(Evaluation evaluation) async {
    final List<Evaluation> currentList = await readEvaluations();
    currentList.add(evaluation);
    final file = await _getLocalFile();
    await file.writeAsString(
      jsonEncode(currentList.map((e) => e.toJson()).toList()),
    );
    log("Évaluation ajoutée !");
  }

  Future<File> _getLocalFile() async {
    return File('../..${ApiConfig.programToDisplayUrl}');
  }
}
