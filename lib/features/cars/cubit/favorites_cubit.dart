import 'package:car_rental_app/features/cars/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesState {
  final List<CarModel> favorites;

  const FavoritesState({this.favorites = const []});

  FavoritesState copyWith({List<CarModel>? favorites}) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
    );
  }
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleFavorite(CarModel car) {
    final currentFavorites = List<CarModel>.from(state.favorites);
    
    final index = currentFavorites.indexWhere((c) => c.id == car.id);

    if (index >= 0) {
      currentFavorites.removeAt(index);
    } else {
      currentFavorites.add(car);
    }

    emit(state.copyWith(favorites: currentFavorites));
  }
}
