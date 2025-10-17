import 'models/car.dart';

class CarsRepository {
  List<Car> getCars() {
    return [
      Car(id: '1', name: 'Toyota Camry', type: 'Sedan', pricePerDay: 40),
      Car(id: '2', name: 'BMW X5', type: 'SUV', pricePerDay: 90),
      Car(id: '3', name: 'Tesla Model 3', type: 'Electric', pricePerDay: 120),
    ];
  }
}
