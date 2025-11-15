import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class _BookingsDataProvider extends InheritedWidget {
  final BookingsContainerState data;

  const _BookingsDataProvider({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_BookingsDataProvider oldWidget) {
    return data.bookings != oldWidget.data.bookings;
  }
}

class BookingsContainer extends StatefulWidget {
  final Widget child;

  const BookingsContainer({super.key, required this.child});

  static BookingsContainerState of(BuildContext context) {
    final _BookingsDataProvider? result =
        context.dependOnInheritedWidgetOfExactType<_BookingsDataProvider>();
    assert(result != null, 'No BookingsContainer found in context');
    return result!.data;
  }

  @override
  BookingsContainerState createState() => BookingsContainerState();
}

class BookingsContainerState extends State<BookingsContainer> {
  // The list of bookings is now immutable.
  List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  void addBooking(BookingModel booking) {
    setState(() {
      // We create a new list every time a booking is added.
      // This makes it easy for updateShouldNotify to detect changes.
      _bookings = [..._bookings, booking];
    });
  }

  @override
  Widget build(BuildContext context) {
    // We wrap the child in our InheritedWidget, passing the state (this) to it.
    // Whenever setState is called, this widget rebuilds, creating a new
    // _BookingsDataProvider, and updateShouldNotify is called.
    return _BookingsDataProvider(
      data: this,
      child: widget.child,
    );
  }
}
