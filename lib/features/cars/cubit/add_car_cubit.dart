import 'dart:math';

import 'package:bloc/bloc.dart';

part 'add_car_state.dart';

class AddCarCubit extends Cubit<AddCarState> {
  AddCarCubit() : super(AddCarInitial());

  final List<String> _availableBrands = [
    'Toyota', 'Honda', 'Ford', 'Nissan', 'Chevrolet', 'Volkswagen', 'BMW', 'Mercedes-Benz'
  ];

  Future<void> addCar({
    required String brand,
    required String model,
    required int year,
    required double price,
    List<String> imageUrls = const [],
  }) async {
    emit(AddCarLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (brand.isEmpty || model.isEmpty) {
        throw Exception('Brand and model cannot be empty.');
      }
      if (!isYearValid(year)) {
        throw Exception('The car year is not valid.');
      }

      print('Simulating add car to repository: $brand $model');

      emit(AddCarSuccess());
    } catch (e) {
      emit(AddCarFailure(e.toString()));
    }
  }

  bool isYearValid(int year) {
    final currentYear = DateTime.now().year;
    return year > 1900 && year <= currentYear + 1;
  }

  Future<List<String>> onUploadImages(List<String> imagePaths) async {
    emit(AddCarLoading()); // Maybe a different state for image uploading
    await Future.delayed(const Duration(seconds: 3));
    
    final uploadedUrls = imagePaths.map((path) {
      final randomId = Random().nextInt(1000);
      return 'https://fake-server.com/images/car_$randomId.jpg';
    }).toList();
    
    emit(AddCarInitial()); // Return to a neutral state
    return uploadedUrls;
  }

  Future<List<String>> fetchAvailableBrands() async {
    // Simulate fetching from a remote or local source
    await Future.delayed(const Duration(milliseconds: 400));
    return _availableBrands..sort();
  }

  void someOtherBusinessLogic() {
    // This could be used for any synchronous operations or checks
    // that don't require a state change but are part of the feature's logic.
    print('Executing some other business logic.');
  }
}
