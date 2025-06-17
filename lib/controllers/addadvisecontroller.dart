import 'package:flutter/cupertino.dart';

import '../models/program_model.dart';
import '../services/program_service.dart';

class AddAdviseController extends ChangeNotifier {
  final ProgramService _programService = ProgramService();

  List<Program> allPrograms = [];
  List<Program> programs = [];
  bool isLoading = false;

  // Déclaration des TextEditingController
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // Libérer les contrôleurs pour éviter les fuites de mémoire
    nameController.dispose();
    //
    super.dispose();
  }

}
