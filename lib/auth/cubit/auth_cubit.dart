import 'package:flutter_bloc/flutter_bloc.dart';

class AuthState {
  final bool isAuthorized;
  final String? login;

  const AuthState({
    this.isAuthorized = false,
    this.login,
  });
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void login(String login) {
    emit(AuthState(isAuthorized: true, login: login));
  }

  void logout() {
    emit(const AuthState(isAuthorized: false, login: null));
  }
}
