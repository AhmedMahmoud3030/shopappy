import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/pages/search_screen.dart';
import 'package:shopappy/pages/settings_screen.dart';
import 'package:shopappy/shared/components/components.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';
import 'package:shopappy/shared/styles/colors.dart';

import '../shared/cubit/app_cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Shopappy'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                navigateTo(context, const SearchScreen());
              },
              icon: const Icon(Icons.search),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: BlocConsumer<AppCubit, AppState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Icon(
                      AppCubit.get(context).isDark
                          ? Icons.brightness_3_sharp
                          : Icons.brightness_7_sharp,
                      color: AppCubit.get(context).isDark
                          ? defaultColor
                          : Colors.black,
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateTo(context, const SettingsScreen());
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (val) => cubit.changeBottom(val),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
              ]),
        );
      },
    );
  }
}
