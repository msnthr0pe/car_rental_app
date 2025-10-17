import 'package:flutter/material.dart';
import '../containers/cars_container.dart';
import '../cars_repository.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/features/bookings/screens/bookings_screen.dart';

class CarsListScreen extends StatelessWidget {
  final CarsRepository repository = CarsRepository();

  CarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = repository.getCars();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
      ),
      body: CarsContainer(
        cars: cars,
        onBookTap: (car) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingFormScreen(car: car),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.list_alt),
        label: const Text('My Bookings'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookingsScreen(),
            ),
          );
        },
      ),
    );

  }
}