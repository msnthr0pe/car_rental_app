import 'package:bloc/bloc.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(const SubscriptionState());

  void loadAvailableBrands() {
    final brands = ['Toyota', 'Honda', 'Ford', 'Nissan', 'Chevrolet', 'Volkswagen', 'BMW', 'Mercedes-Benz'];
    emit(state.copyWith(availableBrands: brands));
  }

  void toggleBrandSelection(String brand) {
    final currentSelection = List<String>.from(state.selectedBrands);
    if (currentSelection.contains(brand)) {
      currentSelection.remove(brand);
    } else {
      currentSelection.add(brand);
    }
    emit(state.copyWith(selectedBrands: currentSelection));
  }

  void activateSubscription() {
    emit(state.copyWith(status: SubscriptionStatus.active));
  }

  void cancelSubscription() {
    emit(state.copyWith(status: SubscriptionStatus.inactive, selectedBrands: []));
  }
}
