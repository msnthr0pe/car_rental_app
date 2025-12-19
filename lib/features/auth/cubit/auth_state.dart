part of 'auth_cubit.dart';

class AuthState {
  final String? login;
  final bool isAuthenticated;

  const AuthState({this.login, this.isAuthenticated = false});
}
