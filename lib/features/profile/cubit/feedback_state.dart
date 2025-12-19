part of 'feedback_cubit.dart';

enum FeedbackCategory { bookingIssue, appError, suggestion }

enum FeedbackStatus { initial, loading, success, failure }

class FeedbackState {
  final FeedbackStatus status;
  final List<FeedbackCategory> categories;
  final FeedbackCategory? selectedCategory;

  const FeedbackState({
    this.status = FeedbackStatus.initial,
    this.categories = FeedbackCategory.values,
    this.selectedCategory,
  });

  FeedbackState copyWith({
    FeedbackStatus? status,
    FeedbackCategory? selectedCategory,
  }) {
    return FeedbackState(
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories,
    );
  }
}
