import 'package:flutter_bloc/flutter_bloc.dart';

class BookingCarCubit extends Cubit<Map<String, String>> {
  BookingCarCubit() : super({});

  void setComment(String carName, String comment) {
    final updatedState = Map<String, String>.from(state);
    updatedState[carName] = comment;
    emit(updatedState);
  }

  void clearComment(String carName) {
    final updatedState = Map<String, String>.from(state);
    updatedState.remove(carName);
    emit(updatedState);
  }
}
