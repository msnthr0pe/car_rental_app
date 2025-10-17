import 'package:flutter/material.dart';
import '../models/car_model.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';

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
