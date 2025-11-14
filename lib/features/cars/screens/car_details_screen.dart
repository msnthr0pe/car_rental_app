import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/cars/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarModel car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: CachedNetworkImage(
                imageUrl: car.pictureLink,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 16),
            Text('Type: ${car.type}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Price: \$${car.pricePerDay}/day', style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  context.push('/booking-form', extra: car);
                },
                child: const Text('Book Now'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
