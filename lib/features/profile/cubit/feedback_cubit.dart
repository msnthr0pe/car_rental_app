import 'package:bloc/bloc.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(const FeedbackState());

  void selectCategory(FeedbackCategory category) {
    emit(state.copyWith(selectedCategory: category));
  }

  Future<void> sendFeedback(String message) async {
    if (state.selectedCategory == null || message.isEmpty) {
      emit(state.copyWith(status: FeedbackStatus.failure));
      emit(state.copyWith(status: FeedbackStatus.initial)); // Reset status
      return;
    }

    emit(state.copyWith(status: FeedbackStatus.loading));

    print('Feedback sent: Category=${state.selectedCategory}, Message=$message');
    
    emit(state.copyWith(status: FeedbackStatus.success));
  }

  void resetStatus(){
        emit(state.copyWith(status: FeedbackStatus.initial));
  }
}
