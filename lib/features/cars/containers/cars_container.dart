import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_rental_app/features/cars/cubit/cars_cubit.dart';
import 'package:car_rental_app/features/cars/cubit/cars_list_cubit.dart';
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
  void initState() {
    super.initState();
    // Initialize the global CarsCubit with data passed to this container
    final cubit = context.read<CarsCubit>();
    if (cubit.state.cars.isEmpty) {
      cubit.updateCars(widget.cars);
      cubit.updatePic(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Lola_T95-30.png/640px-Lola_T95-30.png');
    }
  }

  void _showDescriptionDialog(
      BuildContext context, String carName, String? currentDescription) {
    // Capture the cubit from the context where the dialog is triggered
    final cubit = context.read<CarsListCubit>();
    final controller = TextEditingController(text: currentDescription);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Description for $carName'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter description (e.g. Best in class)',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                cubit.clearDescription(carName);
                Navigator.pop(dialogContext);
              },
              child:
                  const Text('Clear', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                cubit.setDescription(carName, controller.text);
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CarsListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Available Cars'),
        ),
        body: BlocBuilder<CarsCubit, CarsState>(
          builder: (context, carsState) {
            final cars = carsState.cars;
            final mainPicUrl = carsState.mainPicture;
            final favoriteIds = carsState.favoriteIds;
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
                  child: BlocBuilder<CarsListCubit, Map<String, String>>(
                    builder: (context, descriptions) {
                      return ListView.builder(
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];
                          final isFavorite = favoriteIds.contains(car.id);
                          final description = descriptions[car.name];

                          return Column(
                            children: [
                              CarRow(
                                car: car,
                                isFavorite: isFavorite,
                                onTap: () => context.push('/main/car-details',
                                    extra: car),
                                onFavorite: () {
                                  context
                                      .read<CarsCubit>()
                                      .toggleFavorite(car.id);
                                },
                              ),
                              if (description != null &&
                                  description.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.info_outline,
                                          size: 16, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          description,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () => _showDescriptionDialog(
                                      context, car.name, description),
                                  icon: const Icon(Icons.edit_note, size: 16),
                                  label: Text(
                                      description == null
                                          ? 'Add Note'
                                          : 'Edit Note',
                                      style: const TextStyle(fontSize: 12)),
                                ),
                              ),
                              const Divider(),
                            ],
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
