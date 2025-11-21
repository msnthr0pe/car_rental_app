import 'package:car_rental_app/features/bookings/models/booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingsState {
  final List<BookingModel> bookings;

  const BookingsState({this.bookings = const []});

  BookingsState copyWith({List<BookingModel>? bookings}) {
    return BookingsState(
      bookings: bookings ?? this.bookings,
    );
  }
}

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit() : super(const BookingsState());

  void addBooking(BookingModel booking) {
    emit(state.copyWith(bookings: [...state.bookings, booking]));
  }

  void updateBooking(int index, BookingModel updatedBooking) {
    final updatedBookings = List<BookingModel>.from(state.bookings);
    if (index >= 0 && index < updatedBookings.length) {
      updatedBookings[index] = updatedBooking;
      emit(state.copyWith(bookings: updatedBookings));
    }
  }
}
