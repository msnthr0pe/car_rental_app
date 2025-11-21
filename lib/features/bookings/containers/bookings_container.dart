import 'package:car_rental_app/features/bookings/cubit/bookings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingsContainer extends StatelessWidget {
  final Widget child;

  const BookingsContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsCubit(),
      child: child,
    );
  }
}
