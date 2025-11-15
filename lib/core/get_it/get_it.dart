import 'package:car_rental_app/core/services/state_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppStateService>(AppStateService());
}


