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
      body: CarsListView(
        cars: cars,
        onBookTap: (car) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Booking ${car.name}')),
          );
        },
      ),
    );
  }
}

class CarsListView extends StatelessWidget {
  final List<CarModel> cars;
  final Function(CarModel) onBookTap;

  const CarsListView({
    super.key,
    required this.cars,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(car.name),
            subtitle: Text('${car.type} - \$${car.pricePerDay}/day'),
            trailing: ElevatedButton(
              onPressed: () => onBookTap(car),
              child: Text('Book'),
            ),
          ),
        );
      },
    );
  }
}
