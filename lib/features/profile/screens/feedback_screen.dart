import 'package:car_rental_app/features/profile/cubit/feedback_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Feedback'),
        ),
        body: BlocListener<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state.status == FeedbackStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Your feedback has been sent!'),
                  backgroundColor: Colors.green,
                ),
              );
              _messageController.clear();
              context.read<FeedbackCubit>().resetStatus();
            } else if (state.status == FeedbackStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please select a category and enter a message.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCategorySelector(),
                const SizedBox(height: 16),
                TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: 'Your Message',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 24),
                _buildSendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return BlocBuilder<FeedbackCubit, FeedbackState>(
      builder: (context, state) {
        return DropdownButtonFormField<FeedbackCategory>(
          value: state.selectedCategory,
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
          items: state.categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(_getCategoryName(category)),
            );
          }).toList(),
          onChanged: (FeedbackCategory? category) {
            if (category != null) {
              context.read<FeedbackCubit>().selectCategory(category);
            }
          },
        );
      },
    );
  }

  Widget _buildSendButton() {
    return BlocBuilder<FeedbackCubit, FeedbackState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: state.status == FeedbackStatus.loading
              ? null
              : () {
                  context
                      .read<FeedbackCubit>()
                      .sendFeedback(_messageController.text);
                },
          child: state.status == FeedbackStatus.loading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Send Feedback'),
        );
      },
    );
  }

  String _getCategoryName(FeedbackCategory category) {
    switch (category) {
      case FeedbackCategory.bookingIssue:
        return 'Booking Issue';
      case FeedbackCategory.appError:
        return 'App Error';
      case FeedbackCategory.suggestion:
        return 'Suggestion';
      default:
        return '';
    }
  }
}
