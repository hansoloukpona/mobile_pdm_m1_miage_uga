// widgets/university_search_bar_component.dart

import 'package:flutter/material.dart';
import 'package:selectivite/controllers/universitysearchcontroller.dart';

class SearchBarEvalUni extends StatelessWidget {

  final UniversitySearchController searchController;

  const SearchBarEvalUni({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: searchController.nameController,

      decoration: InputDecoration(
        hintText: 'Nom de l\'université...',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            searchController.search();
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
          name: searchController.nameController.text,
          // autres champs...
        );*/
        searchController.search();
      },
    );
  }
}