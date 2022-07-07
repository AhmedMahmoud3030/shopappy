part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}

class LogoutSuccessState extends LoginState {
  LogoutSuccessState();
}

class LogoutErrorState extends LoginState {
  final String message;

  LogoutErrorState(this.message);
}

class ChangeVisibilityState extends LoginState {}

class LoginGetUserLoadingDataState extends LoginState {}

class LoginGetUserSuccessDataState extends LoginState {}

class LoginGetUserErrorDataState extends LoginState {
  final String message;

  LoginGetUserErrorDataState(this.message);
}
