import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/pages/home_screen.dart';
import 'package:shopappy/pages/login_screen.dart';
import 'package:shopappy/pages/on_bording_screen.dart';
import 'package:shopappy/shared/components/constants.dart';
import 'package:shopappy/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';
import 'package:shopappy/shared/cubit/login_cubit/login_cubit.dart';
import 'package:shopappy/shared/network/local/cache_helper.dart';
import 'package:shopappy/shared/network/remote/dio_helper.dart';
import 'package:shopappy/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? isBorading = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  Widget? startWidget;

  if (isBorading!) {
    if (token!.length >= 5) {
      startWidget = const HomeScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = OnBoardingScreen();
  }
  //startWidget = OnBoardingScreen();
  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({
    Key? key,
    this.isDark,
    this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => LoginCubit()..getUserData(),
        ),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getFavoriteData()),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
          print(AppCubit().isDark);
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
