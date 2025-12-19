part of 'add_car_cubit.dart';

abstract class AddCarState {}

class AddCarInitial extends AddCarState {}

class AddCarLoading extends AddCarState {}

class AddCarSuccess extends AddCarState {}

class AddCarFailure extends AddCarState {
  final String error;
  AddCarFailure(this.error);
}
