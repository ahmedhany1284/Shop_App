import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_pp/layout/shop_layout/shop_layout.dart';
import 'package:shop_pp/modules/login/cubit/cubit.dart';
import 'package:shop_pp/modules/login/cubit/states.dart';
import 'package:shop_pp/modules/register/register_screen.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shop_pp/shared/components/constants.dart';
import 'package:shop_pp/shared/network/local/cacheHelper.dart';


class LoginScreen extends StatelessWidget {


  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var emailController=TextEditingController();

  var passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {




    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if (state is LoginSuccessState){
          if(state.loginModel.status!){
            print(state.loginModel.data?.token);
            print(state.loginModel.message);
            CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
            ).then((value) => {
              token = state.loginModel?.data?.token ?? '',

              navigateToAndFinish(context,ShopLayout(),),
              print(state.loginModel.message),
              showToast(
              massage: state.loginModel.message!,
              state: ToastStates.SUCCESS,
              ),
            });
          }else{
            print(state.loginModel.message);
            showToast(
                massage: state.loginModel.message!,
                state: ToastStates.ERROR,);
          }
        }
      },
        builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                      ),
                      // Text(
                      //   'login now to browse our hot offers',
                      //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      // ),
                      const SizedBox(height: 30.0,),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value){
                          if(value!.isEmpty){
                            return 'Please Enter Your Email Adress';
                          }
                          return null;
                        },
                        label: 'Email Adress',
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 15.0,),

                      defaultFormField(
                        isPassword: LoginCubit.get(context).isPassword,
                        controller: passwordController,
                        suffix:  LoginCubit.get(context).suffix,
                        onSubmit: (value){
                          if (formkey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },

                        suffixPressed: (){
                          LoginCubit.get(context).change_pass_visibility();
                        },
                        type: TextInputType.emailAddress,
                        validate: (String? value){
                          if(value!.isEmpty){
                            return 'Password is too short';
                          }
                          return null;
                        },
                        label: 'password',
                        icon: Icons.lock_outline,
                      ),
                      const SizedBox(height: 30.0,),

                      ConditionalBuilder(
                        condition: state is LoginLoadingState,
                        builder: (context)=>Center(child: CircularProgressIndicator()),
                        fallback: ( context)=> defaultButton(
                          function: ()  {
                            if (formkey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'Login',
                        ),
                      ),

                      const SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          const Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function: (){
                              navigateTo(context,  RegisterScreen());
                            },
                            text: 'Register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        );
        },
      ),
    );
  }
}
