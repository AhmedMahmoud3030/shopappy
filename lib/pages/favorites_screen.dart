import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/models/favorite_model.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';

import '../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          builder: (context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(
                cubit.getFavorite!.favData!.proData![index], context),
            itemCount: cubit.getFavorite!.favData!.proData!.length,
          ),
          condition: state is! HomeGetFavoriteLoadingDataState,
          //HomeCubit.get(context).getFavorite != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildFavItem(ProData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 120.0,
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.product!.image!),
                      width: 120.0,
                      height: 120.0,
                    ),
                    if (model.product!.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product!.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            model.product!.price.toString(),
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (model.product!.discount != 0)
                            Text(
                              model.product!.oldPrice.toString(),
                              style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              HomeCubit.get(context)
                                  .changeFavorite(model.product!.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: HomeCubit.get(context)
                                      .favorites[model.product!.id!]!
                                  ? defaultColor
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                size: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
