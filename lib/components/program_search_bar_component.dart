// widgets/university_search_bar_component.dart

import 'package:flutter/material.dart';

import '../controllers/programsearchcontroller.dart';

class SearchBarEvalProgram extends StatelessWidget {

  final ProgramSearchController searchController;

  final String universityId; //TODO Should this be removed ? (because not use anymore)

  const SearchBarEvalProgram({super.key, required this.searchController, required this.universityId});

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: searchController.nameController,

      decoration: InputDecoration(
        hintText: 'Nom de la filière',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            searchController.filterPrograms();
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),

      onChanged: (_) {
        searchController.filterPrograms();
      },
      onSubmitted: (_) {
        searchController.filterPrograms();
      },
    );
  }
}