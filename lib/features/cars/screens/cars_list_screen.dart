import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../cars_repository.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';

class CarsListScreen extends StatelessWidget {
  final CarsRepository repository = CarsRepository();

  CarsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = repository.getCars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
      ),
      body: CarsListView(
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
    );
  }
}

class CarsListView extends StatefulWidget {
  final List<CarModel> cars;
  final Function(CarModel) onBookTap;

  const CarsListView({
    super.key,
    required this.cars,
    required this.onBookTap,
  });

  @override
  _CarsListViewState createState() => _CarsListViewState();
}

class _CarsListViewState extends State<CarsListView> {
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
      itemBuilder: (context, index) {
        final car = _cars[index];
        return CarRow(
          car: car,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingFormScreen(car: car),
              ),
            );
          },
          onFavorite: () {
            setState(() {
              if (!_favorites.contains(car)) {
                _favorites.add(car);
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${car.name} added to favorites')),
            );
          },
        );
      },
    );
  }
}
