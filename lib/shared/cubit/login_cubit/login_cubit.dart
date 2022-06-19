import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopappy/models/login_model.dart';
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

      emit(LoginSucssesState(loginModel!));
    }).catchError((err) {
      print('ERROR: ${err}');
      emit(LoginErrorState(err.toString()));
    });
  }

  bool visibility = true;
  void changePasswordVisibility() {
    visibility = !visibility;
    emit(ChangeVisibilityState());
  }
}
