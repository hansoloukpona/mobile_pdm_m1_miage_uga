import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../models/program_model.dart';
import '../models/program_to_search_request_model.dart';
import '../services/program_service.dart';

class ProgramSearchController extends ChangeNotifier {
  final ProgramService _programService = ProgramService();

  List<Program> programs = [];
  bool isLoading = false;

  // Déclaration des TextEditingController
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // Libérer les contrôleurs pour éviter les fuites de mémoire
    nameController.dispose();
    //
    super.dispose();
  }

  /*
  String? id;
  String name;
  String? description;
  String level;
  String field;
  String? duration;
  String universityId;
  */
  Future<void> search(String universityId) async {
    final request = ProgramToSearchRequest(
      universityId: universityId,
      name: nameController.text.isEmpty ? null : nameController.text,
      page: 0,
      size: 10,
      sortField: 'name',
      sortDirection: 'ASC',
    );

    isLoading = true;
    notifyListeners();

    try {
      /*final results = await programService
          .searchPrograms(request);
      setState(() {
        programs = results;
      });*/

      final String response = await rootBundle.loadString(
        'lib/assets/data/programs.json',
      );
      final List<dynamic> data = json.decode(response);
      programs = data.map((e) => Program.fromJson(e)).toList();
    } catch (e) {
      log('Erreur : $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getallByUniversityId(String universityId) async {
    final request = ProgramToSearchRequest(
      universityId: universityId,
      page: 0,
      size: 10,
      sortField: 'name',
      sortDirection: 'ASC',
    );

    isLoading = true;
    notifyListeners();

    try {
      /*final results = await programService
          .searchPrograms(request);
      setState(() {
        programs = results;
      });*/

      final String response = await rootBundle.loadString(
        'lib/assets/data/programs.json',
      );
      final List<dynamic> data = json.decode(response);
      programs = data.map((e) => Program.fromJson(e)).toList();
    } catch (e) {
      print('Erreur : $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> filterPrograms() async {
    String? entryForFilter =
        nameController.text.isEmpty ? null : nameController.text;

    isLoading = true;
    notifyListeners();

    try {
      final results = await _programService.filterFilieres(
        entryForFilter as String,
        programs,
      );
      programs = results;
    } catch (e) {
      log('Erreur : $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
