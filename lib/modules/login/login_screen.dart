import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_pp/modules/login/cubit/cubit.dart';
import 'package:shop_pp/modules/login/cubit/states.dart';
import 'package:shop_pp/modules/register/register.dart';
import 'package:shop_pp/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class LoginScreen extends StatelessWidget {


  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {



    var emailController=TextEditingController();

    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if (state is LoginSuccessState){
          if(state.loginModel.status!){
            print(state.loginModel.data?.token);
            print(state.loginModel.message);
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else{
            print(state.loginModel.message);
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
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
                        readonly: false,
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
                        readonly: false,
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

                      // ConditionalBuilder(
                      //   condition: state is LoginLoadingState,
                      //   builder: (context)=>Center(child: CircularProgressIndicator()),
                      //   fallback: ( context)=> defaultButton(
                      //     function: ()  {
                      //       if (formkey.currentState!.validate()) {
                      //         LoginCubit.get(context).userLogin(
                      //           email: emailController.text,
                      //           password: passwordController.text,
                      //         );
                      //       }
                      //     },
                      //     text: 'Login',
                      //   ),
                      // ),

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
                              navigateTo(context, const RegisterScreen());
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
