import 'package:car_rental_app/features/cars/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarsState {
  final String? mainPicture;
  final List<CarModel> cars;
  final Set<String> favoriteIds;

  const CarsState({
    this.mainPicture,
    this.cars = const [],
    this.favoriteIds = const {},
  });

  CarsState copyWith({
    String? mainPicture,
    List<CarModel>? cars,
    Set<String>? favoriteIds,
  }) {
    return CarsState(
      mainPicture: mainPicture ?? this.mainPicture,
      cars: cars ?? this.cars,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

class CarsCubit extends Cubit<CarsState> {
  CarsCubit() : super(const CarsState());

  void updatePic(String newPicture) {
    emit(state.copyWith(mainPicture: newPicture));
  }

  void updateCars(List<CarModel> newCars) {
    emit(state.copyWith(cars: newCars));
  }

  void updateCar(CarModel updatedCar) {
    final updatedCars = state.cars.map((car) {
      return car.id == updatedCar.id ? updatedCar : car;
    }).toList();
    emit(state.copyWith(cars: updatedCars));
  }

  void toggleFavorite(String carId) {
    final currentIds = Set<String>.from(state.favoriteIds);
    if (currentIds.contains(carId)) {
      currentIds.remove(carId);
    } else {
      currentIds.add(carId);
    }
    emit(state.copyWith(favoriteIds: currentIds));
  }

  void updateCarName(String carId, String newName) {
    final updatedCars = state.cars.map((car) {
      if (car.id == carId) {
        return car.copyWith(name: newName);
      }
      return car;
    }).toList();
    emit(state.copyWith(cars: updatedCars));
  }
}
