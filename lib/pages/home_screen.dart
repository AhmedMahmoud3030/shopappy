import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/pages/search_screen.dart';
import 'package:shopappy/pages/settings.dart';
import 'package:shopappy/shared/components/components.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Shopappy'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                navigateTo(context, SearchScreen());
              },
              icon: Icon(Icons.search),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SettingsScreen());
                },
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (val) => cubit.changeBottom(val),
              items: [
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
