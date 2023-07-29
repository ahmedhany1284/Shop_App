import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/shared/components/constants.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic>route)=>false
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  bool isPassword = false,
  Function? onTap, // Update the parameter name to onTap
  required String? Function(String?)? validate,
  required String label,
  required IconData icon,
  bool is_clickable=true,
  IconData? suffix,
  VoidCallback? suffixPressed,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    enabled: is_clickable,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit as void Function(String)?,
    onChanged: onChange as void Function(String)?,
    onTap: onTap as void Function()?,
    validator: validate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),

      suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix,),): null,
      border: const OutlineInputBorder(),
    ),
  );
}


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: ()=>function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );



Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function, // Remove the parentheses here
      child: Text(
        text.toUpperCase(),
      ),
    );




void showToast({
  required String massage,
  required ToastStates state,

})=>Fluttertoast.showToast(
    msg: massage,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);



enum ToastStates{SUCCESS,ERROR,WARNONG}
Color ?chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.WARNONG:
      color=Colors.amber;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
  }

  return color;
}


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);



Widget buildListProduct(model,context, {bool isOldPrice =true})=>Padding(
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
              image: NetworkImage('${model?.image}'),
              width: 120.0,
              height: 120.0,
              // fit: BoxFit.cover,
            ),
            model?.discount!=0 && isOldPrice?Container(
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
                '${model?.name}',
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
                    '${model?.price.toString()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: default_color,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  model?.discount!=0 && isOldPrice?Text(
                    '${model?.oldPrice.round()}',
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
                          ShopCubit.get(context).change_fav(model!.id);
                          print(model.id);
                        },
                        icon: Icon(

                          ShopCubit.get(context).fav[model!.id]==true ?Icons.favorite:Icons.favorite_border,
                          color: ShopCubit.get(context).fav[model!.id]==true?Colors.red:default_color,
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


