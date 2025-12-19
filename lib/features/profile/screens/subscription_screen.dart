import 'package:car_rental_app/features/profile/cubit/subscription_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionCubit()..loadAvailableBrands(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Subscription'),
        ),
        body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatus(context, state.status),
                  const SizedBox(height: 24),
                  const Text(
                    'Select brands for your monthly discount:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _buildBrandList(context, state),
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context, SubscriptionStatus status) {
    final isSubscribed = status == SubscriptionStatus.active;
    return Row(
      children: [
        const Text('Subscription Status: ', style: TextStyle(fontSize: 18)),
        Text(
          isSubscribed ? 'Active' : 'Inactive',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSubscribed ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          isSubscribed ? Icons.check_circle : Icons.cancel,
          color: isSubscribed ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildBrandList(BuildContext context, SubscriptionState state) {
    return ListView.builder(
      itemCount: state.availableBrands.length,
      itemBuilder: (context, index) {
        final brand = state.availableBrands[index];
        final isSelected = state.selectedBrands.contains(brand);
        return CheckboxListTile(
          title: Text(brand),
          value: isSelected,
          onChanged: (bool? value) {
            context.read<SubscriptionCubit>().toggleBrandSelection(brand);
          },
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context, SubscriptionState state) {
    final isSubscribed = state.status == SubscriptionStatus.active;

    if (isSubscribed) {
      return Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              // Here you would typically confirm changes
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscription updated!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: const Text('Update Subscription'),
          ),
          const SizedBox(height: 8),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              context.read<SubscriptionCubit>().cancelSubscription();
            },
            child: const Text('Cancel Subscription'),
          ),
        ],
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.green,
      ),
      onPressed: state.selectedBrands.isNotEmpty
          ? () {
              context.read<SubscriptionCubit>().activateSubscription();
            }
          : null,
      child: const Text('Activate Subscription'),
    );
  }
}
