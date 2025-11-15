import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/core/get_it/get_it.dart';
import 'package:car_rental_app/core/services/state_service.dart';
import 'package:flutter/material.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!locator.isRegistered<AppStateService>()) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Bookings'),
        ),
        body: const Center(
          child: Text(
            'Error: StateService is not initialized.',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    final appStateService = locator.get<AppStateService>();
    final status = appStateService.status;

    const String imageUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Navy_Sad_Face.png/640px-Navy_Sad_Face.png';

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 100,
              width: 100,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                radius: 50,
              ),
              progressIndicatorBuilder: (context, url, progress) =>
                  const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            // Displaying the status from the service
            Text(
              status,
              style: textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
