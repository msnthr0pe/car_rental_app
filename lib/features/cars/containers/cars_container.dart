import 'package:flutter/material.dart';
import '../../bookings/models/booking_model.dart';
import '../models/car_model.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';

enum AppScreen { carsList, bookingForm, bookings }

class CarsContainer extends StatefulWidget {
  final List<CarModel> cars;

  const CarsContainer({super.key, required this.cars});

  @override
  _CarsContainerState createState() => _CarsContainerState();
}

class _CarsContainerState extends State<CarsContainer> {
  late List<CarModel> _cars;
  final List<CarModel> _favorites = [];
  final List<BookingModel> _bookings = [];

  AppScreen _currentScreen = AppScreen.carsList;
  CarModel? _selectedCar;

  @override
  void initState() {
    super.initState();
    _cars = List.from(widget.cars);
  }

  void _navigateTo(AppScreen screen, {CarModel? car}) {
    setState(() {
      _currentScreen = screen;
      _selectedCar = car;
    });
  }

  void _addBooking(BookingModel booking) {
    setState(() {
      _bookings.add(booking);
      _currentScreen = AppScreen.carsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_currentScreen) {
      case AppScreen.carsList:
        body = ListView.builder(
          itemCount: _cars.length,
          itemBuilder: (context, index) {
            final car = _cars[index];
            return CarRow(
              car: car,
              isFavorite: _favorites.contains(car),
              onTap: () => _navigateTo(AppScreen.bookingForm, car: car),
              onFavorite: () {
                setState(() {
                  if (_favorites.contains(car)) {
                    _favorites.remove(car);
                  } else {
                    _favorites.add(car);
                  }
                });
              },
            );
          },
        );
        break;

      case AppScreen.bookingForm:
        body = BookingFormScreen(
          car: _selectedCar!,
          onSubmit: _addBooking,
          onCancel: () => _navigateTo(AppScreen.carsList),
        );
        break;

      case AppScreen.bookings:
        body = _bookings.isEmpty
            ? const Center(child: Text('No bookings yet.'))
            : ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (context, index) {
            final booking = _bookings[index];
            final car = booking.car;
            return ListTile(
              title: Text(car.name),
              subtitle: Text(
                  'From: ${booking.startDate.toIso8601String().split("T")[0]} '
                      'To: ${booking.endDate.toIso8601String().split("T")[0]}'),
            );
          },
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentScreen == AppScreen.carsList
            ? 'Available Cars'
            : _currentScreen == AppScreen.bookings
            ? 'My Bookings'
            : 'Booking Form'),
      ),
      body: body,
      floatingActionButton: _currentScreen == AppScreen.carsList
          ? FloatingActionButton.extended(
        icon: const Icon(Icons.list_alt),
        label: const Text('My Bookings'),
        onPressed: () => _navigateTo(AppScreen.bookings),
      )
          : null,
    );
  }
}
