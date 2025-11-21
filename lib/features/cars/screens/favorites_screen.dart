import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/cars/cubit/favorites_cubit.dart';
import 'package:car_rental_app/shared/widgets/car_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Cars'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final favorites = state.favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorites yet.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final car = favorites[index];
              return CarRow(
                car: car,
                isFavorite: true,
                onTap: () => context.push('/main/car-details', extra: car),
                onFavorite: () {
                  context.read<FavoritesCubit>().toggleFavorite(car);
                },
              );
            },
          );
        },
      ),
    );
  }
}
