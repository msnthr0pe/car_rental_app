import 'package:flutter_bloc/flutter_bloc.dart';

class BookingState {
  final DateTime? startDate;
  final DateTime? endDate;
  final double price;

  const BookingState({
    this.startDate,
    this.endDate,
    this.price = 0.0,
  });

  BookingState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    double? price,
  }) {
    return BookingState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
    );
  }
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  // Для совместимости со старым кодом (если где-то используется updateDate,
  // хотя мы обновляем экран тоже) оставим или заменим?
  // Промпт просил updateDate, но теперь просит редактировать ОБЕ даты.
  // Я заменю updateDate на updateStartDate и updateEndDate.

  void updateStartDate(DateTime newDate) {
    emit(state.copyWith(startDate: newDate));
  }

  void updateEndDate(DateTime newDate) {
    emit(state.copyWith(endDate: newDate));
  }

  void updatePrice(double newPrice) {
    emit(state.copyWith(price: newPrice));
  }
  
  // Temporary alias if needed by other files I don't see, but likely safe to remove updateDate
  // since I just created this file.
  // However, previous prompt said "методы updateDate и updatePrice", so I will keep updateDate
  // as an alias for updateStartDate to be safe, or just refactor.
  // Refactoring is better.
}
