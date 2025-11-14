import 'package:car_rental_app/features/bookings/screens/bookings_screen.dart';
import 'package:car_rental_app/features/cars/screens/car_details_screen.dart';
import 'package:car_rental_app/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../models/car_model.dart';
import '../../../shared/widgets/car_row.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarsContainer extends StatefulWidget {
  final List<CarModel> cars;

  const CarsContainer({super.key, required this.cars});

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
    const String mainPicUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Lola_T95-30.png/640px-Lola_T95-30.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
          ),
        ],
      ),
      body: _cars.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://cdn-icons-png.flaticon.com/512/1048/1048953.png',
                    width: 150,
                    height: 150,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _cars.length,
                    itemBuilder: (context, index) {
                      final car = _cars[index];
                      return CarRow(
                        car: car,
                        isFavorite: _favorites.contains(car),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => CarDetailsScreen(car: car)),
                        ),
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
            ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.list_alt),
        label: const Text('My Bookings'),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const BookingsScreen()),
        ),
      ),
    );
  }
}
