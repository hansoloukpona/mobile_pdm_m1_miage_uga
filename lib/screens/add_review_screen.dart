import 'package:flutter/material.dart';

import '../models/formations.dart';

class AddReviewScreen extends StatefulWidget {
  final String programId;

  const AddReviewScreen({Key? key, required this.programId}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();

  Formations? selectedFormation;
  double? tauxAdmission;
  int? nbCandidatures;
  double? noteMinimale;
  int selectiviteRessentie = 1;
  String? delaiReponse;
  List<String> criteresSelection = [];
  String commentaire = '';

  final TextEditingController _criteresController = TextEditingController();

  void _saveReview() {
    if (_formKey.currentState!.validate() && selectedFormation != null) {
      setState(() {
        selectedFormation!
          ..tauxAdmission = tauxAdmission
          ..nbCandidatures = nbCandidatures
          ..noteMinimale = noteMinimale
          ..selectiviteRessentie = selectiviteRessentie
          ..delaiReponse = delaiReponse
          ..criteresSelection = criteresSelection
          ..commentaire = commentaire;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Avis enregistré pour ${selectedFormation!.nom}")),
      );

      Navigator.pop(context);
    }
  }

  void _addCritere(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        criteresSelection.add(text.trim());
        _criteresController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une évaluation")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Sélection de la formation
              /* DropdownButtonFormField<Formations>(
                value: selectedFormation,
                hint: const Text("Choisissez une formation"),
                items: widget.formations.map((f) {
                  return DropdownMenuItem<Formations>(
                    value: f,
                    child: Text("${f.nom} (${f.universite})"),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedFormation = val),
                validator: (val) =>
                val == null ? "Sélectionnez une formation" : null,
              ),
              const SizedBox(height: 20),*/

              // Taux d'admission
              TextFormField(
                decoration: InputDecoration(
                  labelText: "🎯 Taux d'admission (%)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) => tauxAdmission = int.tryParse(val) as double?,
              ),
              const SizedBox(height: 16),

              // Nombre de candidatures
              TextFormField(
                decoration: InputDecoration(
                  labelText: "📥 Nombre de candidatures",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) => nbCandidatures = int.tryParse(val),
              ),
              const SizedBox(height: 16),

              // Note minimale
              TextFormField(
                decoration: InputDecoration(
                  labelText: "📊 Note minimale",
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) => noteMinimale = double.tryParse(val),
              ),
              const SizedBox(height: 16),

              // Sélectivité ressentie
              Text("⭐ Sélectivité ressentie (1 à 5)"),
              Slider(
                value: selectiviteRessentie.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: "$selectiviteRessentie",
                onChanged: (val) =>
                    setState(() => selectiviteRessentie = val.toInt()),
              ),
              const SizedBox(height: 16),

              // Délai de réponse
              DropdownButtonFormField<String>(
                value: delaiReponse,
                hint: Text("⏱ Délai de réponse"),
                items: ['Rapide', 'Moyen', 'Long']
                    .map((d) =>
                    DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (val) => setState(() => delaiReponse = val),
              ),
              const SizedBox(height: 16),

              // Critères de sélection
              Text("📋 Critères de sélection"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _criteresController,
                      decoration: InputDecoration(
                        hintText: "Ajouter un critère",
                      ),
                      onSubmitted: _addCritere,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _addCritere(_criteresController.text),
                  )
                ],
              ),
              Wrap(
                spacing: 8,
                children: criteresSelection
                    .map((c) => Chip(
                  label: Text(c),
                  onDeleted: () => setState(() =>
                      criteresSelection.remove(c)),
                ))
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Commentaire
              TextFormField(
                decoration: InputDecoration(
                  labelText: "💬 Commentaire",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (val) => commentaire = val,
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _saveReview,
                child: const Text("Valider"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
