import 'package:car_rental_app/auth/cubit/auth_cubit.dart';
import 'package:car_rental_app/features/bookings/cubit/booking_car_cubit.dart';
import 'package:car_rental_app/features/bookings/cubit/bookings_cubit.dart';
import 'package:car_rental_app/features/cars/cubit/cars_cubit.dart';
import 'package:car_rental_app/features/cars/cubit/favorites_cubit.dart';
import 'package:car_rental_app/core/bloc/bloc_observer.dart';
import 'package:car_rental_app/core/get_it/get_it.dart';
import 'package:car_rental_app/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => BookingsCubit()),
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => CarsCubit()),
        BlocProvider(create: (context) => BookingCarCubit()),
      ],
      child: const MyApp(),
    ),
  );
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
