import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/cubit/states.dart';
import 'package:shop_pp/models/models.dart';
import 'package:shop_pp/shared/components/components.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ListView.separated(
          itemBuilder: (context,index)=>buildCategoriesItem(cubit.categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=>myDivider(),
          itemCount: cubit.categoriesModel!.data!.data.length,
        );
      },

    );
  }

  Widget buildCategoriesItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
  children:
  [
  Image(
  image: NetworkImage('${model.image}'),
  width: 80.0,
  height: 80.0,
  ),
  SizedBox(width: 20.0,),
  Text(
  '${model.name}',
  style: TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  Spacer(),
  Icon(Icons.arrow_forward_ios)
  ],
  ),
  );
}
