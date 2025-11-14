import 'package:car_rental_app/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/cars/models/car_model.dart';
import '../../features/cars/screens/cars_list_screen.dart';
import '../../features/bookings/screens/booking_form_screen.dart';
import '../../features/bookings/screens/bookings_screen.dart';
import '../../features/cars/screens/car_details_screen.dart';
import '../../features/profile/screens/profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return CarsListScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'booking-form',
            builder: (BuildContext context, GoRouterState state) {
              final car = state.extra as CarModel;
              return BookingFormScreen(
                car: car,
              );
            },
          ),
          GoRoute(
            path: 'car-details',
            builder: (BuildContext context, GoRouterState state) {
              final car = state.extra as CarModel;
              return CarDetailsScreen(car: car);
            },
          ),
        ]),
    GoRoute(
      path: '/bookings',
      builder: (BuildContext context, GoRouterState state) {
        return const BookingsScreen();
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
  ],
);
