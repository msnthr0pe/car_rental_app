import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/bookings/cubit/bookings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: BlocBuilder<BookingsCubit, BookingsState>(
        builder: (context, state) {
          final bookings = state.bookings;

          if (bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Navy_Sad_Face.png/640px-Navy_Sad_Face.png',
                    height: 100,
                    width: 100,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 50,
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No bookings yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              final dateFormat = DateFormat('yyyy-MM-dd');

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: booking.car.pictureLink,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  title: Text(booking.car.name),
                  subtitle: Text(
                    '${dateFormat.format(booking.startDate)} - ${dateFormat.format(booking.endDate)}',
                  ),
                  trailing: Text(
                    '\$${booking.car.pricePerDay}/day',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
