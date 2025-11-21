import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/bookings/cubit/booking_cubit.dart';
import 'package:car_rental_app/features/bookings/cubit/bookings_cubit.dart';
import 'package:car_rental_app/features/bookings/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  void _showEditDialog(BuildContext context, BookingModel booking, int index) {
    final bookingsCubit = context.read<BookingsCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider(
          create: (context) => BookingCubit()
            ..updateStartDate(booking.startDate)
            ..updateEndDate(booking.endDate)
            ..updatePrice(booking.car.pricePerDay),
          child: BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              final cubit = context.read<BookingCubit>();
              final dateFormat = DateFormat('yyyy-MM-dd');
              return AlertDialog(
                title: const Text('Edit Booking'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text('Start Date'),
                      subtitle: Text(state.startDate != null
                          ? dateFormat.format(state.startDate!)
                          : 'Select Start Date'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: state.startDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          cubit.updateStartDate(picked);
                        }
                      },
                    ),
                    ListTile(
                      title: const Text('End Date'),
                      subtitle: Text(state.endDate != null
                          ? dateFormat.format(state.endDate!)
                          : 'Select End Date'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: state.endDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          cubit.updateEndDate(picked);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: state.price.toString(),
                      decoration: const InputDecoration(
                        labelText: 'Price per Day',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final val = double.tryParse(value);
                        if (val != null) {
                          cubit.updatePrice(val);
                        }
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final newCar =
                          booking.car.copyWith(pricePerDay: state.price);
                      final newBooking = BookingModel(
                        car: newCar,
                        startDate: state.startDate ?? booking.startDate,
                        endDate: state.endDate ?? booking.endDate,
                      );

                      bookingsCubit.updateBooking(index, newBooking);
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

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
                    imageUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Navy_Sad_Face.png/640px-Navy_Sad_Face.png',
                    height: 100,
                    width: 100,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 50,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: booking.car.pictureLink,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                    ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            _showEditDialog(context, booking, index);
                          },
                          child: const Text('Изменить'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
