import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:selectivite/models/university_model.dart';

import '../screens/university_details_screen.dart';
import 'card_list_eval_bouton_component.dart';
import 'card_list_standard_bouton_component.dart';

class UniversityCard extends StatelessWidget {

  final University university;

  const UniversityCard({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Colors.white,
              Color(0x1A004AAD), // Bleu très léger (~10% opacité)
              Color(0x1A004AAD),
            ],
            stops: [0.0, 0.75, 0.85, 1.0], // Dégradé à partir de 75%
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              // Partie cliquable (texte université)
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UniversityDetails(university: university),
                      ),
                    );

                    // Navigation vers les détails de l'université
                    log("Détails de l'université : \$university");
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        university.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Voir les détails de cette université",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.0),

              // Colonne des deux boutons à droite
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Cardliststandardbouton(value: Text("Filières")),
                  SizedBox(height: 8.0),
                  Cardlistevalbouton(value: Text("Évaluer")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}