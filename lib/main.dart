import 'package:car_rental_app/core/get_it/get_it.dart';
import 'package:car_rental_app/core/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  // Initialize get_it before running the app.
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Car Rental App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}
