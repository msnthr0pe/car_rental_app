import 'package:car_rental_app/features/cars/cubit/add_car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddCarCubit(),
      child: const _AddCarScreenContent(),
    );
  }
}

class _AddCarScreenContent extends StatefulWidget {
  const _AddCarScreenContent();

  @override
  State<_AddCarScreenContent> createState() => _AddCarScreenContentState();
}

class _AddCarScreenContentState extends State<_AddCarScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _brandController.clear();
    _modelController.clear();
    _yearController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Car'),
      ),
      body: BlocListener<AddCarCubit, AddCarState>(
        listener: (context, state) {
          if (state is AddCarSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Car added successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _clearForm();
          } else if (state is AddCarFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the brand';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _modelController,
                  decoration: const InputDecoration(labelText: 'Model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the model';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _yearController,
                  decoration: const InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the year';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid year';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price per day'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<AddCarCubit, AddCarState>(
                  builder: (context, state) {
                    if (state is AddCarLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddCarCubit>().addCar(
                                brand: _brandController.text,
                                model: _modelController.text,
                                year: int.parse(_yearController.text),
                                price: double.parse(_priceController.text),
                              );
                        }
                      },
                      child: const Text('Add Car'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
