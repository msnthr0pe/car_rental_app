import 'package:flutter/material.dart';
import 'package:car_rental_app/features/cars/models/car_model.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';
import 'package:car_rental_app/features/bookings/screens/booking_form_screen.dart';

class CarFavoritesTable extends StatelessWidget {
  final List<CarModel> favoriteCars;
  final Function(CarModel)? onRemoveFavorite;

  const CarFavoritesTable({
    super.key,
    required this.favoriteCars,
    this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteCars.isEmpty) {
      return const Center(
        child: Text('No favorite cars yet.'),
      );
    }

    return ListView.builder(
      itemCount: favoriteCars.length,
      itemBuilder: (BuildContext context, int index) {
        final car = favoriteCars[index];
        return CarRow(
          car: car,
          isFavorite: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingFormScreen(car: car),
              ),
            );
          },
          onFavorite: () {
            if (onRemoveFavorite != null) {
              onRemoveFavorite!(car);
            }
          },
        );
      },
    );
  }
}
