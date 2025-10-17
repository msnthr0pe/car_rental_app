import 'package:car_rental_app/features/cars/models/car_model.dart';

class BookingModel {
  final CarModel car;
  final DateTime startDate;
  final DateTime endDate;

  BookingModel({
    required this.car,
    required this.startDate,
    required this.endDate,
  });
}
