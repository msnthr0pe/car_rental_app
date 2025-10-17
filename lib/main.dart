import 'package:flutter/material.dart';
import 'features/cars/screens/cars_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CarsListScreen(),
    );
  }
}
