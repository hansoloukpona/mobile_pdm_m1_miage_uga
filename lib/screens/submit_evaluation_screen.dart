import 'package:flutter/material.dart';
import '../models/formations.dart';

class SubmitEvaluationScreen extends StatefulWidget {
  final Formations formation;

  const SubmitEvaluationScreen({super.key, required this.formation});

  @override
  State<SubmitEvaluationScreen> createState() => _SubmitEvaluationScreenState();
}

class _SubmitEvaluationScreenState extends State<SubmitEvaluationScreen> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _studyYearController = TextEditingController();
  int submissionYear = DateTime.now().year;

  final Map<String, int> ratings = {
    'Selectivity': 0,
    'Quality of Education': 0,
    'Academic Rigor': 0,
    'Career Preparedness': 0,
    'Supervision': 0,
    'Satisfaction': 0,
  };

  bool hasDroppedOut = false;

  void _setRating(String category, int rating) {
    setState(() {
      ratings[category] = rating;
    });
  }

  void _submit() {
    print("Formation: ${widget.formation.nom}");
    print("Study Year: ${_studyYearController.text}");
    print("Submission Year: $submissionYear");
    print("Ratings: $ratings");
    print("Dropped out: $hasDroppedOut");
    print("Commentaire: ${_commentController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Évaluation envoyée pour ${widget.formation.nom}")),
    );

    Navigator.pop(context);
  }

  Widget _buildStarRating(String category) {
    final rating = ratings[category]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => _setRating(category, index + 1),
            );
          }),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Submit Evaluation"),
        backgroundColor: Colors.lightBlue[200],
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          children: [
            Text(widget.formation.nom, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(widget.formation.universite ?? "", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),

            ...['Selectivity', 'Quality of Education', 'Academic Rigor', 'Career Preparedness']
                .map(_buildStarRating)
                .toList(),

            const SizedBox(height: 8),
            Text("📘 Study Year", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _studyYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter your current study year",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Text("📅 Submission Year", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => setState(() {
                    if (submissionYear > 2000) submissionYear--;
                  }),
                ),
                Expanded(
                  child: Text("$submissionYear", textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => setState(() => submissionYear++),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildStarRating('Supervision'),
            _buildStarRating('Satisfaction'),

            Row(
              children: [
                Checkbox(
                  value: hasDroppedOut,
                  onChanged: (val) => setState(() => hasDroppedOut = val ?? false),
                ),
                const Text("Has dropped out"),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Other Comments", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Enter your comments",
                border: OutlineInputBorder(),
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("SUBMIT", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
