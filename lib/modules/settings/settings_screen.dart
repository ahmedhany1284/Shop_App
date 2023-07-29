import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_pp/layout/cubit/cubit.dart';
import 'package:shop_pp/layout/cubit/states.dart';
import 'package:shop_pp/modules/login/login_screen.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:shop_pp/shared/cubit/cubit.dart';
import 'package:shop_pp/shared/cubit/states.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';

class SettingsScreen extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if (state is ShopSuccessUpdateUserStates){
          if(state.loginModel!.status!){
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel?.data?.token,
            ).then((value) => {
              showToast(
                massage: state.loginModel!.message!,
                state: ToastStates.SUCCESS,
              ),
            });
          }else{
            print(state.loginModel!.message);
            showToast(
              massage: state.loginModel!.message!,
              state: ToastStates.ERROR,);
          }
        }
      },
      builder: (context,state){
        var model=ShopCubit.get(context).usermodel;
        nameController.text = model?.data?.name ??'';
        emailController.text = model?.data?.email ??'';
        phoneController.text = model?.data?.phone ??'';
        if(ShopCubit.get(context).usermodel!=null){
          return Form(
            key: formkey,
            child: BlocBuilder<AppCubit,AppStates>(
              builder: (context,state){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [

                      if(state is ShopLoadingUpdateUserStates )LinearProgressIndicator(),
                      SizedBox(height: 20.0,),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (String ?value){
                          if(value!.isEmpty){
                            return 'Name must not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        icon: Icons.person,
                      ),
                      SizedBox(height: 10.0,),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String ?value){
                          if(value!.isEmpty){
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email Adress',
                        icon: Icons.email_outlined,
                      ),
                      SizedBox(height: 10.0,),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String ?value){
                          if(value!.isEmpty){
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        icon: Icons.phone_android_outlined,
                      ),
                      SizedBox(height: 10.0,),
                      defaultButton(
                        function: ()
                        {
                          if(formkey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }

                        },
                        text: 'Update',
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        children:
                        [
                          Text(
                            'Mode',
                          ),
                          Spacer(),
                          IconButton(
                            icon:Icon(!AppCubit.get(context).isDark!?Icons.light_mode:Icons.dark_mode),
                            onPressed: (){
                              AppCubit.get(context).changeAppMode();

                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 10.0,),
                      defaultButton(
                        function: () {
                          SignOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        else{
          return Center(child: CircularProgressIndicator());
        }

      },

    );
  }
}
