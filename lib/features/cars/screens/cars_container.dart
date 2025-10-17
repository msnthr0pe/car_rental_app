import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../cars_repository.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/features/bookings/screens/bookings_screen.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';

class CarsListScreen extends StatelessWidget {
  final CarsRepository repository = CarsRepository();

  CarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = repository.getCars();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
      ),
      body: CarsContainer(
        cars: cars,
        onBookTap: (car) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingFormScreen(car: car),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.list_alt),
        label: const Text('My Bookings'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookingsScreen(),
            ),
          );
        },
      ),
    );

  }
}


class CarsContainer extends StatefulWidget {
  final List<CarModel> cars;
  final Function(CarModel) onBookTap;

  const CarsContainer({
    super.key,
    required this.cars,
    required this.onBookTap,
  });

  @override
  _CarsContainerState createState() => _CarsContainerState();
}

class _CarsContainerState extends State<CarsContainer> {
  late List<CarModel> _cars;
  final List<CarModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    _cars = List.from(widget.cars);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _cars.length,
      itemBuilder: (BuildContext context, int index) {
        final car = _cars[index];
        return CarRow(
          car: car,
          isFavorite: _favorites.contains(car),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingFormScreen(car: car),
              ),
            );
          },
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
  }
}
