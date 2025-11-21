import 'package:car_rental_app/features/cars/cubit/cars_cubit.dart';
import 'package:car_rental_app/features/cars/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _showEditDialog(BuildContext context, String carId, String currentName) {
    // context здесь приходит из itemBuilder, поэтому он видит локальный FavoritesCubit
    final favoritesCubit = context.read<FavoritesCubit>();
    favoritesCubit.updateCarName(currentName);

    showDialog(
      context: context,
      builder: (dialogContext) {
        // Передаем локальный кубит в контекст диалога
        return BlocProvider.value(
          value: favoritesCubit,
          child: BlocBuilder<FavoritesCubit, String>(
            builder: (context, nameState) {
              return AlertDialog(
                title: const Text('Edit Car Name'),
                content: TextField(
                  controller: TextEditingController(text: nameState)
                    ..selection =
                        TextSelection.collapsed(offset: nameState.length),
                  onChanged: (value) {
                    context.read<FavoritesCubit>().updateCarName(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter new car name',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Сохраняем изменения в глобальный CarsCubit
                      context.read<CarsCubit>().updateCarName(carId, nameState);
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Favorites'),
        ),
        body: BlocBuilder<CarsCubit, CarsState>(
          builder: (context, state) {
            final favoriteIds = state.favoriteIds;
            final favoriteCars =
                state.cars.where((c) => favoriteIds.contains(c.id)).toList();

            if (favoriteCars.isEmpty) {
              return const Center(
                child: Text(
                  'No favorites yet.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: favoriteCars.length,
              itemBuilder: (context, index) {
                final car = favoriteCars[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      car.pictureLink,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      car.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('\$${car.pricePerDay}/day'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          // Передаем context элемента списка, который "видит" FavoritesCubit
                          onPressed: () =>
                              _showEditDialog(context, car.id, car.name),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () =>
                              context.read<CarsCubit>().toggleFavorite(car.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
