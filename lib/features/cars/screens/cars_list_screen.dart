import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../cars_repository.dart';

class CarsListScreen extends StatelessWidget {
  final CarsRepository repository = CarsRepository();

  CarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = repository.getCars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return ListTile(
            title: Text(car.name),
            subtitle: Text('${car.type} - \$${car.pricePerDay}/day'),
          );
        },
      ),
    );
  }
}
