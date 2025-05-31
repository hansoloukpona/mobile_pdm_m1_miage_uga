import 'package:flutter/material.dart';

import '../models/program_model.dart';
import '../models/program_to_search_request_model.dart';
import '../services/program_service.dart';
import 'search_bar_screen.dart';
import 'university_card_screen.dart';

class UniversityDetails extends StatefulWidget {
  const UniversityDetails({Key? key}) : super(key: key);

  @override
  State<UniversityDetails> createState() => _UniversityDetailsState();
}

class _UniversityDetailsState extends State<UniversityDetails> {

  List<Program> formations = [];

  final programService = ProgramService();

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // Libérer les contrôleurs pour éviter les fuites de mémoire
    nameController.dispose();
    //
    super.dispose();
  }

  Future<void> search() async {
    final request = ProgramToSearchRequest(
      name: nameController.text.isEmpty ? null : nameController.text,
      //country: countryController.text.isEmpty ? null : countryController.text,
      //city: cityController.text.isEmpty ? null : cityController.text,
      //type: typeController.text.isEmpty ? null : typeController.text,
      page: 0,
      size: 10,
      sortField: 'name',
      sortDirection: 'ASC',
    );

    try {
      final results = await programService
          .searchPrograms(request);
      setState(() {
        formations = results;
      });
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B7EBE),
      appBar: AppBar(
        title: Text("Rechercher une université"),
        backgroundColor: Color(0xFF4B7EBE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarEval(),
            SizedBox(height: 20),
            Text("Résultats", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: formations.length,
                itemBuilder: (context, index) {
                  return UniversityCard(university: formations[index].name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DataService _dataService = DataService();
  bool _isLoading = false;

  void _searchFormations() async {
    setState(() => _isLoading = true);

    List<Formations> allFormations = await _dataService.loadFormations();


    String query = _searchController.text.toLowerCase();
    print(allFormations); // Affiche toutes les formations
    print("Query: $query");


    List<Formations> filtered = allFormations.where((f) {
      return f.nom.toLowerCase().contains(query) ||
          f.ville.toLowerCase().contains(query) ||
          f.universite.toLowerCase().contains(query);
    }).toList();

    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(formations: filtered),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélectivité des universités"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Rechercher une formation ou une ville",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Ex: informatique, Grenoble...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton.icon(
              onPressed: _searchFormations,
              icon: Icon(Icons.search),
              label: Text("Rechercher"),
            ),
            SizedBox(height: 24),
            Divider(),
            TextButton(
              onPressed: () {
                // plus tard : navigation vers ajout d'avis
                Navigator.pushNamed(context, '/add-review');

              },
              child: Text("Ajouter un avis ?"),
            ),
            TextButton(
              onPressed: () {
                // lien vers contact/info

              },
              child: Text("Besoin d'aide ? Contactez-nous"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
