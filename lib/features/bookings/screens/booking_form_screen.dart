import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/bookings/containers/bookings_container.dart';
import 'package:flutter/material.dart';
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
      final start = DateTime.parse(_startDateController.text);
      final end = DateTime.parse(_endDateController.text);

      final booking = BookingModel(
        car: widget.car,
        startDate: start,
        endDate: end,
      );

      BookingsContainer.of(context).addBooking(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking saved!')),
      );

      context.go('/');
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
