import 'package:flutter/material.dart';
import 'features/cars/screens/cars_list_screen.dart';

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarsListScreen(),
    );
  }
}
