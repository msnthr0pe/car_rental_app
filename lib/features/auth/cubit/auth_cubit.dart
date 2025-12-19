import 'package:bloc/bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void login(String login) {
    emit(AuthState(login: login, isAuthenticated: true));
  }

  void logout() {
    emit(const AuthState(isAuthenticated: false));
  }
}
