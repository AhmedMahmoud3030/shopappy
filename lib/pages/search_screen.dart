// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopappy/shared/components/components.dart';

import '../shared/cubit/search_cubit/search_cubit.dart';
import '../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  defaultFormField(
                    onSubmit: (val) {
                      SearchCubit.get(context).search(val);
                    },
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return 'enter text to search';
                      } else {
                        return null;
                      }
                    },
                    label: 'search',
                    prefix: Icons.search,
                  ),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.builder(
                          itemCount: cubit.model!.data!.reData!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                height: 120.0,
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Image(
                                          image: NetworkImage(cubit.model!.data!
                                              .reData![index].image!),
                                          width: 120.0,
                                          height: 120.0,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.model!.data!.reData![index]
                                                .name!,
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
                                                cubit.model!.data!
                                                    .reData![index].price
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: defaultColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
