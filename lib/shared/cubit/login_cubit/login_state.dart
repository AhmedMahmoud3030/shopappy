part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSucssesState extends LoginState {
  final LoginModel loginModel;

  LoginSucssesState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}

class ChangeVisibilityState extends LoginState {}
