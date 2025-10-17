import 'models/car_model.dart';

class CarsRepository {
  List<CarModel> getCars() {
    return [
      CarModel(id: '1', name: 'Toyota Camry', type: 'Sedan', pricePerDay: 40),
      CarModel(id: '2', name: 'BMW X5', type: 'SUV', pricePerDay: 90),
      CarModel(id: '3', name: 'Tesla Model 3', type: 'Electric', pricePerDay: 120),
    ];
  }
}
