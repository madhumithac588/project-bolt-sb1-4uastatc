import 'package:flutter/material.dart';
import 'package:flora_emosens/models/plant.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plant.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _buildStatusRow(
                Icons.thermostat,
                'Temperature',
                '${plant.temperature}°C',
              ),
              _buildStatusRow(
                Icons.water_drop,
                'Humidity',
                '${plant.humidity}%',
              ),
              _buildStatusRow(
                Icons.opacity,
                'Water Level',
                '${plant.waterLevel}%',
              ),
              _buildStatusRow(
                Icons.eco,
                'Nutrient Level',
                '${plant.nutrientLevel}%',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }
}