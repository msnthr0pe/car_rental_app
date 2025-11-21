import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<String> {
  FavoritesCubit() : super('Initial Car Name');

  void updateCarName(String newName) {
    emit(newName);
  }
}
