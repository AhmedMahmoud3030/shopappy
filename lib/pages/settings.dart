import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/pages/home_screen.dart';
import 'package:shopappy/shared/components/components.dart';
import 'package:shopappy/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shopappy/shared/cubit/login_cubit/login_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined)),
      ),
    );
  }
}
