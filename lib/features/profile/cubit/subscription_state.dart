part of 'subscription_cubit.dart';

enum SubscriptionStatus { active, inactive }

class SubscriptionState {
  final SubscriptionStatus status;
  final List<String> availableBrands;
  final List<String> selectedBrands;

  const SubscriptionState({
    this.status = SubscriptionStatus.inactive,
    this.availableBrands = const [],
    this.selectedBrands = const [],
  });

  SubscriptionState copyWith({
    SubscriptionStatus? status,
    List<String>? availableBrands,
    List<String>? selectedBrands,
  }) {
    return SubscriptionState(
      status: status ?? this.status,
      availableBrands: availableBrands ?? this.availableBrands,
      selectedBrands: selectedBrands ?? this.selectedBrands,
    );
  }
}
