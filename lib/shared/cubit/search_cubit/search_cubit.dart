import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/models/search_model.dart';
import 'package:shopappy/shared/network/end_points.dart';
import 'package:shopappy/shared/network/remote/dio_helper.dart';

import '../../components/constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(token: token, endPoint: PRODUCTSEARCH, data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((err) {
      emit(SearchError(err));
      debugPrint(err);
    });
  }
}
