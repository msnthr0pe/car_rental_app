import 'package:flutter_bloc/flutter_bloc.dart';

class CarsListCubit extends Cubit<Map<String, String>> {
  CarsListCubit() : super({});

  void setDescription(String carName, String description) {
    final updatedState = Map<String, String>.from(state);
    updatedState[carName] = description;
    emit(updatedState);
  }

  void clearDescription(String carName) {
    final updatedState = Map<String, String>.from(state);
    updatedState.remove(carName);
    emit(updatedState);
  }
}
