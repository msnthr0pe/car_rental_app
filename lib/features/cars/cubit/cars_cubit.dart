import 'package:car_rental_app/features/cars/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarsState {
  final String? mainPicture;
  final List<CarModel> cars;

  const CarsState({
    this.mainPicture,
    this.cars = const [],
  });

  CarsState copyWith({
    String? mainPicture,
    List<CarModel>? cars,
  }) {
    return CarsState(
      mainPicture: mainPicture ?? this.mainPicture,
      cars: cars ?? this.cars,
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
}
