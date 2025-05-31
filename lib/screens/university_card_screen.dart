import 'package:flutter/material.dart';

import 'university_details_screen.dart';

class UniversityCard extends StatelessWidget {
  final String university;

  UniversityCard({required this.university});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UniversityDetails(/*liste de formtions*/),
            ),
          );
          // Navigation vers les détails de l'université
          print("Détails de l'université : \$university");
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  university,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("Voir filières pour \$university");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004AAD),
                    ),
                    child: Text("Filières"),
                  ),
                  //SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      print("Évaluer \$university");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004AAD),
                    ),
                    child: Text("Évaluer"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      /*child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              university,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                    minimumSize: const Size(40, 40), // carré 40x40
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black, // couleur de la bordure
                        width: 1,            // épaisseur de la bordure
                      ),
                      borderRadius: BorderRadius.circular(4), // coins carrés
                    ),
                    padding: EdgeInsets.zero, // supprime le padding par défaut
                  ),
                  child: const Icon(
                    Icons.info_outline, // une icône évocatrice pour "détails"
                    color: Colors.white,
                    size: 20,
                  ),
                  /*style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004AAD),
                  ),
                  child: Text("Détails"),*/
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004AAD),
                  ),
                  child: Text("Filières"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004AAD),
                  ),
                  child: Text("Évaluer"),
                ),
              ],
            )
          ],
        ),
      ),*/
    );
  }
}