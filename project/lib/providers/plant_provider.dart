import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PlantProvider with ChangeNotifier {
  List<String> _plants = [];
  List<String> _filteredPlants = [];
  bool _isLoading = false;

  List<String> get plants =>
      _filteredPlants.isEmpty ? _plants : _filteredPlants;
  bool get isLoading => _isLoading;

  // Fetch plants from the API
  Future<void> fetchPlants() async {
    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/api/user'),
      headers: {'Authorization': 'Bearer your_jwt_token_here'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _plants = List<String>.from(data['plants']);
      _filteredPlants = _plants; // By default, show all plants
    } else {
      // Handle the error
      print('Failed to load plants');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Filter plants based on search query
  void filterPlants(String query) {
    if (query.isEmpty) {
      _filteredPlants =
          _plants; // If the search query is empty, show all plants
    } else {
      _filteredPlants = _plants
          .where((plant) => plant.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners to update the UI
  }
}
