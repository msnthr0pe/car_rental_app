import 'package:flutter/material.dart';
import '../containers/cars_container.dart';
import '../cars_repository.dart';

class CarsListScreen extends StatelessWidget {
  final CarsRepository repository = CarsRepository();

  CarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = repository.getCars();

    return CarsContainer(cars: cars);
  }
}
