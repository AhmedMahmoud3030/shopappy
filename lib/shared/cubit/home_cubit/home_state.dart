part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeBottomNavState extends HomeState {}

class HomeScreenLoadingDataState extends HomeState {}

class HomeScreenSuccessDataState extends HomeState {}

class HomeScreenErrorDataState extends HomeState {
  final String message;

  HomeScreenErrorDataState(this.message);
}

class HomeCategoryLoadingDataState extends HomeState {}

class HomeCategorySuccessDataState extends HomeState {}

class HomeCategoryErrorDataState extends HomeState {
  final String message;

  HomeCategoryErrorDataState(this.message);
}

class HomeChangeFavoriteState extends HomeState {}

class HomeChangeErrorFavoriteState extends HomeState {
  final String message;

  HomeChangeErrorFavoriteState(this.message);
}
