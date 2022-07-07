import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/pages/login_screen.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';
import 'package:shopappy/shared/cubit/login_cubit/login_cubit.dart';

import '../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image(
                      height: 250,
                      image: NetworkImage(cubit.userData!.data!.image!),
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  '${cubit.userData!.data!.name}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Email: ${cubit.userData!.data!.email}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Phone: ${cubit.userData!.data!.phone}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                    function: () {
                      cubit.userSignout();
                      navigateAndFinish(context, LoginScreen());
                    },
                    text: 'LOGOUT',
                    background: Colors.blueAccent,
                    radius: 14,
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
