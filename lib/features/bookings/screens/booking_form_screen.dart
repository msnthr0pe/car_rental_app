import 'package:flutter/material.dart';
import '../../cars/models/car_model.dart';
import '../containers/bookings_container.dart';
import '../models/booking_model.dart';

class BookingFormScreen extends StatefulWidget {
  final CarModel car;

  const BookingFormScreen({super.key, required this.car});

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

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter start date';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter end date';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _onConfirmTap, child: const Text('Confirm Booking')),
            ],
          ),
        ),
      ),
    );
  }
}
