import 'package:flutter/material.dart';
import '../models/formations.dart';
import 'details_screen.dart';

class ResultsScreen extends StatelessWidget {
  final List<Formations> formations;

  const ResultsScreen({Key? key, required this.formations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats de la recherche'),
      ),
      body: formations.isEmpty
          ? Center(
        child: Text(
          'Aucune formation trouvée.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: formations.length,
        itemBuilder: (context, index) {
          final formation = formations[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              title: Text(
                formation.nom,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(formation.universite),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(formation: formation),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}





/**onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => DetailsScreen(formation: formation),
),
);
}*/