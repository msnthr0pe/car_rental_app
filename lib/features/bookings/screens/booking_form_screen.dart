import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/bookings/cubit/booking_car_cubit.dart';
import 'package:car_rental_app/features/bookings/cubit/bookings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../cars/models/car_model.dart';
import '../models/booking_model.dart';

class BookingFormScreen extends StatefulWidget {
  final CarModel car;

  const BookingFormScreen({
    super.key,
    required this.car,
  });

  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _onConfirmTap() {
    if (_formKey.currentState!.validate()) {
      final start = DateTime.tryParse(_startDateController.text);
      final end = DateTime.tryParse(_endDateController.text);

      if (start == null || end == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid date format. Use YYYY-MM-DD')),
        );
        return;
      }

      final booking = BookingModel(
        car: widget.car,
        startDate: start,
        endDate: end,
      );

      context.read<BookingsCubit>().addBooking(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking saved!')),
      );

      context.go('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking for ${widget.car.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: CachedNetworkImage(
                  imageUrl: widget.car.pictureLink,
                  height: 200,
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _startDateController,
                      decoration: const InputDecoration(
                          labelText: 'Start Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _endDateController,
                      decoration: const InputDecoration(
                          labelText: 'End Date (YYYY-MM-DD)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter end date';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Comment about the car:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              BlocBuilder<BookingCarCubit, Map<String, String>>(
                builder: (context, comments) {
                  final currentComment = comments[widget.car.name];
                  final options = [
                    "приятный салон",
                    "хороша в вождении",
                    "экономичная",
                    "быстрая"
                  ];

                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: options.map((option) {
                      final isSelected = currentComment == option;
                      return ChoiceChip(
                        label: Text(option),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            context
                                .read<BookingCarCubit>()
                                .setComment(widget.car.name, option);
                          } else {
                            context
                                .read<BookingCarCubit>()
                                .clearComment(widget.car.name);
                          }
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onConfirmTap,
                child: const Text('Confirm Booking'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
