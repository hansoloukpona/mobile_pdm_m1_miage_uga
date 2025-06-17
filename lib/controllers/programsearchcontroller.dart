import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:selectivite/dtos/program_to_display_model.dart';

import '../dtos/program_to_search_request_model.dart';
import '../models/program_model.dart';
import '../services/program_service.dart';

class ProgramSearchController extends ChangeNotifier {
  final ProgramService _programService = ProgramService();

  List<ProgramToDisplay> brutSearchResultOfProgram = []; //TODO Changer par une liste d'un dto spécial qui inclus le nom de l'université et sa ville
  List<Program> allProgramsOfAUni = [];
  List<Program> filteredProgramsOfAUni = [];
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
      filteredProgramsOfAUni = data.map((e) => Program.fromJson(e)).toList();
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
      allProgramsOfAUni = data.map((e) => Program.fromJson(e)).toList();
      filteredProgramsOfAUni = allProgramsOfAUni;
    } catch (e) {
      log('Erreur : $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchAnyProgram() async {
    final request = ProgramToSearchRequest(
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
      brutSearchResultOfProgram = data.map((e) => ProgramToDisplay.fromJson(e)).toList();
    } catch (e) {
      log('Erreur : $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> filterPrograms() async {

    if(nameController.text.isEmpty) {
      filteredProgramsOfAUni = allProgramsOfAUni;
    } else {
      isLoading = true;
      notifyListeners();

      String? entryForFilter = nameController.text;
      try {
        final results = _programService.filterFilieres(
          entryForFilter,
          filteredProgramsOfAUni,
        );
        filteredProgramsOfAUni = results;
      } catch (e) {
        log('Erreur : $e');
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
