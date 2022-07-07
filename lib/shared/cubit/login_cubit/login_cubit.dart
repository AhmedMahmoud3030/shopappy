import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/models/login_model.dart';
import 'package:shopappy/shared/components/constants.dart';
import 'package:shopappy/shared/network/end_points.dart';
import 'package:shopappy/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      endPoint: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      //print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      token = loginModel!.data!.token;

      emit(LoginSuccessState(loginModel!));
    }).catchError((err) {
      //print('ERROR: $err');
      emit(LoginErrorState(err.toString()));
    });
  }

  void userSignout() {
    emit(LoginLoadingState());
    DioHelper.postData(
      endPoint: LOGOUT,
      data: {
        'fcm_token': token,
      },
    ).then((value) {
      debugPrint(value.data);

      emit(LogoutSuccessState());
    }).catchError((err) {
      //print('ERROR: $err');
      emit(LogoutErrorState(err.toString()));
    });
  }

  bool visibility = true;
  void changePasswordVisibility() {
    visibility = !visibility;
    emit(ChangeVisibilityState());
  }

  LoginModel? userData;
  void getUserData() async {
    emit(LoginGetUserLoadingDataState());
    await DioHelper.getData(endPoint: PROFILE, token: token).then((value) {
      userData = LoginModel.fromJson(value.data);
      debugPrint("userData");

      emit(LoginGetUserSuccessDataState());
    }).catchError((err) {
      //print(err.toString());
      emit(LoginGetUserErrorDataState(err.toString()));
    });
  }
}
