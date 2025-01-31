import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart';

class MyPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger fetching plants when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlantProvider>(context, listen: false).fetchPlants();
    });

    return Scaffold(
      appBar: AppBar(title: Text('My Plants')),
      body: Consumer<PlantProvider>(
        builder: (context, plantProvider, child) {
          return plantProvider.isLoading
              ? const Center(child: CircularProgressIndicator()) // Show loader
              : ListView.builder(
                  itemCount: plantProvider.plants.length, // Number of plants
                  itemBuilder: (context, index) {
                    final plant = plantProvider.plants[index];
                    return ListTile(
                      title: Text(plant), // Display plant name
                    );
                  },
                );
        },
      ),
    );
  }
}
