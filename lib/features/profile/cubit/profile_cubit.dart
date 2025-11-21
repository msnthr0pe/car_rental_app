import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<Map<String, String>> {
  ProfileCubit() : super({});

  void setStatus(String login, String status) {
    final updatedState = Map<String, String>.from(state);
    updatedState[login] = status;
    emit(updatedState);
  }

  void clearStatus(String login) {
    final updatedState = Map<String, String>.from(state);
    updatedState.remove(login);
    emit(updatedState);
  }
}
