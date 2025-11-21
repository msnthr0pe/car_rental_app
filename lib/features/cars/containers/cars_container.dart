import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/cars/cubit/cars_cubit.dart';
import 'package:car_rental_app/features/cars/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../models/car_model.dart';
import '../../../shared/widgets/car_row.dart';

class CarsContainer extends StatefulWidget {
  final List<CarModel> cars;

  const CarsContainer({super.key, required this.cars});

  @override
  _CarsContainerState createState() => _CarsContainerState();
}

class _CarsContainerState extends State<CarsContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarsCubit()
        ..updateCars(widget.cars)
        ..updatePic(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Lola_T95-30.png/640px-Lola_T95-30.png'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Available Cars'),
        ),
        body: BlocBuilder<CarsCubit, CarsState>(
          builder: (context, carsState) {
            final cars = carsState.cars;
            final mainPicUrl = carsState.mainPicture;

            if (cars.isEmpty) {
              return Center(
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
              );
            }

            return Column(
              children: [
                if (mainPicUrl != null)
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
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, favState) {
                      return ListView.builder(
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];
                          final isFavorite = favState.favorites
                              .any((c) => c.id == car.id);

                          return CarRow(
                            car: car,
                            isFavorite: isFavorite,
                            onTap: () =>
                                context.push('/main/car-details', extra: car),
                            onFavorite: () {
                              context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(car);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
