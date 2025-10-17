import 'package:flutter/material.dart';
import '../containers/bookings_container.dart';
import '../models/booking_model.dart';
import '../../cars/models/car_model.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = BookingsContainer.of(context).bookings;

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet.'))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final BookingModel booking = bookings[index];
          final CarModel car = booking.car;

          return ListTile(
            title: Text(car.name),
            subtitle: Text(
              'From: ${booking.startDate.toIso8601String().split("T")[0]} '
                  'To: ${booking.endDate.toIso8601String().split("T")[0]}',
            ),
          );
        },
      ),
    );
  }
}
