import 'package:flutter/material.dart';
import 'package:car_rental_app/features/cars/models/car_model.dart';

class CarRow extends StatelessWidget {
  final CarModel car;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavorite;

  CarRow({
    super.key,
    required this.car,
    this.onTap,
    this.isFavorite = false,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.directions_car),
        title: Text(car.name),
        subtitle: Text('${car.type} - \$${car.pricePerDay}/day'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: onFavorite,
            ),
            ElevatedButton(
              onPressed: onTap,
              child: const Text('Book'),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
