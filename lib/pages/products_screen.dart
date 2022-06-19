import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/models/categories_model.dart';
import 'package:shopappy/shared/components/components.dart';
import 'package:shopappy/shared/cubit/home_cubit/home_cubit.dart';
import 'package:shopappy/shared/styles/colors.dart';

import '../models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categorieModel != null,
          builder: (context) => builderWidget(
              (HomeCubit.get(context).homeModel) as HomeModel,
              (HomeCubit.get(context).categorieModel) as CategoriesModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget builderWidget(HomeModel homeModel, CategoriesModel cateModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: homeModel.data!.banners!
                    .map(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Card(
                          child: Image(
                            image: NetworkImage(e.image!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: false,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(
                          (cateModel.data!.data![index]) as CatData),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: cateModel.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.58,
                  children: List.generate(
                    homeModel.data!.products!.length,
                    (index) =>
                        buildGridProduct(homeModel.data!.products![index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildGridProduct(Products model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                            ),
                          ),
                          onPressed: () {
                            print(model.inFavorites);
                            print(model.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(CatData model) => ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 100,
          width: 110,
          child: Card(
            elevation: 12,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                ),
                Container(
                  width: 110,
                  color: Colors.black54,
                  child: Text(
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    model.name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
