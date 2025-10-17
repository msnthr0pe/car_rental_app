class CarModel {
  final String id;
  final String name;
  final String type;
  final double pricePerDay;

  CarModel({
    required this.id,
    required this.name,
    required this.type,
    required this.pricePerDay,
  });

  CarModel copyWith({
    String? id,
    String? name,
    String? type,
    double? pricePerDay,
  }) {
    return CarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      pricePerDay: pricePerDay ?? this.pricePerDay,
    );
  }
}
