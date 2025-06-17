import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../dtos/university_to_search_request_model.dart';
import '../models/university_model.dart';
import '../services/university_service.dart';

class UniversitySearchController extends ChangeNotifier {

  final UniversityService _universityService = UniversityService();

  List<University> universities = [];
  bool isLoading = false;

  // Déclaration des TextEditingController
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  void dispose() {
    // Libérer les contrôleurs pour éviter les fuites de mémoire
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    typeController.dispose();
    super.dispose();
  }

  Future<void> search() async {
    final UniversityToSearchRequest request = UniversityToSearchRequest(
      name: nameController.text.isEmpty ? null : nameController.text,
      country: countryController.text.isEmpty ? null : countryController.text,
      city: cityController.text.isEmpty ? null : cityController.text,
      type: typeController.text.isEmpty ? null : typeController.text,
      page: 0,
      size: 10,
      sortField: 'name',
      sortDirection: 'ASC',
    );

    isLoading = true;
    notifyListeners();

    try {
    //universities = await _universityService.searchUniversities(request);
      final String response = await rootBundle.loadString('lib/assets/data/universities.json');
      final List<dynamic> data = json.decode(response);
      universities = data.map((e) => University.fromJson(e)).toList();
    } catch (e) {
      log('Erreur : $e');
    }

    isLoading = false;
    notifyListeners();
  }
}