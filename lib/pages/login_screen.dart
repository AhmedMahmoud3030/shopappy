import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/pages/home_screen.dart';
import 'package:shopappy/pages/register_screen.dart';
import 'package:shopappy/shared/components/components.dart';
import 'package:shopappy/shared/cubit/login_cubit/login_cubit.dart';
import 'package:shopappy/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //!old one not tested
  // var emailController = TextEditingController();
  // var passwordController = TextEditingController();
  // var formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status!) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              return customToast(
                msg: state.loginModel.message.toString(),
                color: Colors.greenAccent,
              ).then((value) => navigateAndFinish(context, const HomeScreen()));
            });
          } else {
            customToast(
              msg: state.loginModel.message.toString(),
              color: Colors.redAccent,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'login now to browse or hot offers',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'please enter your email';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        onSubmit: (_) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_open_outlined,
                        isPassword: LoginCubit.get(context).visibility,
                        suffix: LoginCubit.get(context).visibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        fallback: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Don\'t have an account '),
                          defaultTextButton(
                            function: () {
                              //AppCubit.get(context).changeAppMode();
                              navigateTo(context, const RegisterScreen());
                            },
                            text: 'Sign Up',
                            isUpperCase: true,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
