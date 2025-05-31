// widgets/search_bar_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectivite/controllers/universitysearchcontroller.dart';

import '../models/university_to_search_request_model.dart';

class SearchBarEval extends StatelessWidget {
  SearchBarEval({super.key});

  @override
  Widget build(BuildContext context) {
    final UniversitySearchController universitySearchController = Provider.of<UniversitySearchController>(context, listen: false);
    return TextField(
      controller: universitySearchController.nameController,

      decoration: InputDecoration(
        hintText: 'Nom de l\'université...',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            universitySearchController.search();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),

      onSubmitted: (_) {
        /*final request = UniversityToSearchRequest(
          name: universitySearchController.nameController.text,
          // autres champs...
        );*/
        universitySearchController.search();
      },
    );
  }
}