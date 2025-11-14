import 'package:cached_network_image/cached_network_image.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('My Bookings'),
      ),
      body: bookings.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Navy_Sad_Face.png/640px-Navy_Sad_Face.png',
                    width: 150,
                    height: 150,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  const SizedBox(height: 16),
                  const Text('No bookings yet.'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final BookingModel booking = bookings[index];
                final CarModel car = booking.car;

                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: car.pictureLink,
                    width: 150,
                    height: 70,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
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
