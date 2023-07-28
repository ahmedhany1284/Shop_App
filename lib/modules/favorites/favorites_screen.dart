import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/cubit/states.dart';
import 'package:shop_pp/models/favorites_model.dart';
import 'package:shop_pp/models/on_boarding_model.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/components/constants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! ShopLoadingGetFavStates) {
          if (cubit.favModel != null && cubit.favModel!.data != null) {
            if (cubit.favModel!.data!.data.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) =>
                    buildFavItem(cubit.favModel!.data!.data[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favModel!.data!.data.length,
              );
            } else {
              return is_null(context);
            }
          } else {
            // Handle the case where favModel or its properties are null.
            return is_null(context);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }


  Widget buildFavItem(FavoritesData   model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      width: 120.0,
      height: 120.0,
      child: Row(

        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.product?.image}'),
                width: 120.0,
                height: 120.0,
                // fit: BoxFit.cover,
              ),
              model.product?.discount!=0?Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ):Text(''),
            ],
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.product?.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product?.price.toString()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: default_color,
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    model.product?.discount!=0?Text(
                      '${model.product?.oldPrice.round()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ):Text(''),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0, 2), // Adjust the offset to control the position of the shadow.
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 15.5,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).change_fav(model.product!.id);
                            print(model.id);
                          },
                          icon: Icon(

                            ShopCubit.get(context).fav[model.product!.id]==true ?Icons.favorite:Icons.favorite_border,
                            color: ShopCubit.get(context).fav[model.product!.id]==true?Colors.red:default_color,
                            size: 14.0,
                          ),
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
  );

  Widget is_null(context)=>Center(
    child: Text(
      'Favorites Screen',
      style: Theme.of(context).textTheme.bodyText1,
    ),
  );
}

