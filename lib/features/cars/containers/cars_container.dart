import 'package:flutter/material.dart';
import '../../bookings/models/booking_model.dart';
import '../models/car_model.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

    const String mainPicUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Lola_T95-30.png/640px-Lola_T95-30.png';

    switch (_currentScreen) {
      case AppScreen.carsList:
        body = _cars.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/1048/1048953.png',
                      width: 150,
                      height: 150,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(height: 16),
                    const Text('No cars available.'),
                  ],
                ),
              )
            : Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: mainPicUrl,
                    width: 500,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _cars.length,
                      itemBuilder: (context, index) {
                        final car = _cars[index];
                        return CarRow(
                          car: car,
                          isFavorite: _favorites.contains(car),
                          onTap: () =>
                              _navigateTo(AppScreen.bookingForm, car: car),
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
                    ),
                  ),
                ],
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
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Navy_Sad_Face.png/640px-Navy_Sad_Face.png',
                      width: 150,
                      height: 150,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(height: 16),
                    const Text('No bookings yet.'),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _bookings.length,
                itemBuilder: (context, index) {
                  final booking = _bookings[index];
                  final car = booking.car;
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: car.pictureLink,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
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
