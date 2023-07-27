

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_pp/models/models.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatelessWidget {
  // const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=ShopCubit.get(context);
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {
        if(state is ShopSuccessChangeFavStates){
          if(state.model.status==false){
            showToast(
                massage: '${state.model.message}',
                state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
            condition:ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).categoriesModel!=null ,
            builder:(context)=> ProductBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel!,context) ,
            fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
    },
    );
  }
  ScrollController _controller = ScrollController();
  Widget ProductBuilder(HomeModel? model,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    controller: _controller,
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: model?.data?.banners.map((e) =>Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ) ).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage:0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
          ),
        ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800
                ),

              ),
              SizedBox(height: 10.0,),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index)=> buildCategoryItem(categoriesModel.data!.data[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                  itemCount: categoriesModel.data!.data.length,
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                'Products',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800
                ),

              ),
            ],
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio:  1/1.58 ,
            children:List.generate(
                model!.data!.products.length,
                (index) =>buildGridProduct(model.data!.products[index],context) ,),
          ),
        ),
      ],
    ),
  );

Widget buildCategoryItem(DataModel model)=>Container(
  height: 100.0,
  width: 100.0,
  child: Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image:NetworkImage('${model.image}'),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
        width: double.infinity,
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  ),
);

  Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200.0,
              // fit: BoxFit.cover,
            ),
            model.discount!=0?Container(
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: default_color,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  model.discount!=0?Text(
                    '${model.old_price.round()}',
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
                        ShopCubit.get(context).change_fav(model.id!);
                        print(model.id);
                      },
                      icon: Icon(

                        ShopCubit.get(context).fav[model.id]==true ?Icons.favorite:Icons.favorite_border,
                        color: ShopCubit.get(context).fav[model.id]==true?Colors.red:default_color,
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
  );
}
