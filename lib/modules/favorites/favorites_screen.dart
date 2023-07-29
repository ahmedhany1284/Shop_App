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
                    buildListProduct(cubit.favModel!.data!.data[index].product, context),
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




  Widget is_null(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the padding based on the screen dimensions.
    // You can adjust the padding values as per your preference.
    final horizontalPadding = screenWidth * 0.1; // 10% of screen width
    final verticalPadding = screenHeight * 0.2; // 20% of screen height

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image:  AssetImage('assets/images/add_fav.png'),
              width: 100.0,
              height: 100.0,
              color: Colors.grey[500],
            ),
            Text(
              'Start Adding items you love to your favorite list by tapping on the heart icon.',
              overflow: TextOverflow.visible,
              style: TextStyle(
                  color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,

            ),
          ],
        ),
      ),
    );
  }

}

