import 'package:flutter/material.dart';
import '../models/formations.dart';
import '../services/data_service.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
