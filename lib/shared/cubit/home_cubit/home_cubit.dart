import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/models/categories_model.dart';
import 'package:shopappy/models/change_favorites_model.dart';
import 'package:shopappy/models/favorite_model.dart';
import 'package:shopappy/models/home_model.dart';
import 'package:shopappy/pages/categories_screen.dart';
import 'package:shopappy/pages/favorites_screen.dart';
import 'package:shopappy/pages/products_screen.dart';
import 'package:shopappy/shared/components/constants.dart';
import 'package:shopappy/shared/network/end_points.dart';
import 'package:shopappy/shared/network/remote/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(HomeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() async {
    emit(HomeScreenLoadingDataState());
    await DioHelper.getData(endPoint: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.products!) {
        favorites.addAll({element.id!: element.inFavorites!});
      }

      //print(favorites.toString());

      emit(HomeScreenSuccessDataState());
    }).catchError((err) {
      //print(err.toString());
      emit(HomeScreenErrorDataState(err.toString()));
    });
  }

  ChangeFavoriteModel? favoriteModel;
  void changeFavorite(int id) async {
    favorites[id] = !favorites[id]!;
    await DioHelper.postData(
            data: {'product_id': id}, endPoint: FAVORITES, token: token)
        .then((value) {
      favoriteModel = ChangeFavoriteModel.fromJson(value.data);
      emit(HomeChangeFavoriteState(favoriteModel!));
      if (!favoriteModel!.status!) {
        favorites[id] = !favorites[id]!;
      } else {
        getFavoriteData();
      }
    }).catchError((err) {
      favorites[id] = !favorites[id]!;

      emit(HomeChangeErrorFavoriteState(err.toString()));
    });
  }

  CategoriesModel? categorieModel;
  void getCategoryData() async {
    emit(HomeCategoryLoadingDataState());
    await DioHelper.getData(
      endPoint: CATEGORY,
    ).then((value) {
      categorieModel = CategoriesModel.fromJson(value.data);

      emit(HomeCategorySuccessDataState());
    }).catchError((err) {
      //print(err.toString());
      emit(HomeCategoryErrorDataState(err.toString()));
    });
  }

  Favorite? getFavorite;
  void getFavoriteData() async {
    emit(HomeGetFavoriteLoadingDataState());
    await DioHelper.getData(endPoint: FAVORITES, token: token).then((value) {
      getFavorite = Favorite.fromJson(value.data);
      debugPrint(getFavorite!.message.toString());

      emit(HomeGetFavoriteSuccessDataState());
    }).catchError((err) {
      //print(err.toString());
      emit(HomeGetFavoriteErrorDataState(err.toString()));
    });
  }
}
