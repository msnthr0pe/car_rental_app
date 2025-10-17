import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class BookingsContainer extends StatefulWidget {
  final Widget child;

  const BookingsContainer({super.key, required this.child});

  static _BookingsContainerState of(BuildContext context) {
    final _BookingsContainerState? result =
    context.findAncestorStateOfType<_BookingsContainerState>();
    assert(result != null, 'No BookingsContainer found in context');
    return result!;
  }

  @override
  _BookingsContainerState createState() => _BookingsContainerState();
}

class _BookingsContainerState extends State<BookingsContainer> {
  final List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  void addBooking(BookingModel booking) {
    setState(() {
      _bookings.add(booking);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
