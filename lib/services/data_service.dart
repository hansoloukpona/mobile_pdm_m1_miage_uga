import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/formations.dart';

class DataService {

  Future<List<Formations>> loadFormations() async {
    final String response = await rootBundle.loadString('lib/assets/data/formations.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => Formations.fromJson(e)).toList();
  }

}
