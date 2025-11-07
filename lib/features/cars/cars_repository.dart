import 'package:car_rental_app/features/cars/models/car_model.dart';

class CarsRepository {
  List<CarModel> getCars() {
    return [
      CarModel(id: '1', name: 'Toyota Camry', type: 'Sedan', pricePerDay: 40, pictureLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/TOYOTA_CAMRY_%28XV80%29_China_%282%29.jpg/640px-TOYOTA_CAMRY_%28XV80%29_China_%282%29.jpg'),
      CarModel(id: '2', name: 'BMW X5', type: 'SUV', pricePerDay: 90, pictureLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/2019_BMW_X5_M50d_Automatic_3.0.jpg/640px-2019_BMW_X5_M50d_Automatic_3.0.jpg'),
      CarModel(id: '3', name: 'Tesla Model 3', type: 'Electric', pricePerDay: 120, pictureLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Tesla_Model_3_%282023%29_Autofr%C3%BChling_Ulm_IMG_9282.jpg/330px-Tesla_Model_3_%282023%29_Autofr%C3%BChling_Ulm_IMG_9282.jpg'),
    ];
  }
}
