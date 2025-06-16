import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/university_card_component.dart';
import '../components/university_search_bar_component.dart';
import '../controllers/universitysearchcontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            SearchBarEvalUni(
              searchController: Provider.of<UniversitySearchController>(
                context,
                listen: false,
              ),
            ),
            SizedBox(height: 20),
            Text("Résultats", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<UniversitySearchController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (controller.universities.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Aucun résultat trouvé.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Souhaitez-vous créer une nouvelle évaluation ?",
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/add_review_screen');
                            },
                            icon: Icon(Icons.add),
                            label: Text("Créer une évaluation"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.universities.length,
                    itemBuilder: (context, index) {
                      final university = controller.universities[index];
                      return UniversityCard(university: university);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
