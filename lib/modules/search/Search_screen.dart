import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/modules/search/cubit/cubit.dart';
import 'package:shop_pp/modules/search/cubit/states.dart';
import 'package:shop_pp/shared/components/components.dart';


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String ?value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (text) {
                        SearchCubit.get(context).search(text!);
                      },
                      label: 'Search',
                      icon: Icons.search,
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          if (SearchCubit.get(context).model?.data?.data != null &&
                              SearchCubit.get(context).model!.data!.data!.isNotEmpty &&
                              index < SearchCubit.get(context).model!.data!.data!.length) {
                            return buildListProduct(
                              SearchCubit.get(context).model!.data!.data![index], // Use null-aware operator and index safely
                              context,
                              isOldPrice: false,
                            );
                          } else {
                            return Container(); // Return an empty container or a loading indicator here
                          }
                        },
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).model?.data?.data?.length ?? 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
