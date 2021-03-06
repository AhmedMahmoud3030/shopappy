import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/models/categories_model.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context);
        return ListView.builder(
            itemBuilder: (context, index) =>
                buildCatItem(model.categorieModel!.data!.data![index]),
            itemCount: model.categorieModel!.data!.data!.length);
      },
    );
  }

  Widget buildCatItem(CatData model) => Container(
        padding: const EdgeInsets.all(8),
        height: 100,
        child: Card(
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                model.name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
              )
            ],
          ),
        ),
      );
}
