import 'package:car_rental_app/features/auth/screens/login_screen.dart';
import 'package:car_rental_app/features/bookings/containers/bookings_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingsContainer(
      child: MaterialApp(
        title: 'Car Rental App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginScreen(),
      ),
    );
  }
}
