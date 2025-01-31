class Plant {
  final String id;
  final String name;
  final double temperature;
  final double humidity;
  int waterLevel;
  int nutrientLevel;

  Plant({
    required this.id,
    required this.name,
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
    required this.nutrientLevel,
  });
}
