import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/shop_layout_screen.dart';
import 'package:shopapp/modules/shop_app/login/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';

import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/style/colors.dart';

class RegisterScreen extends StatelessWidget {
   var formKey = GlobalKey<FormState>();
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) =>LoginShopCubit(),
        child: BlocConsumer<LoginShopCubit,ShopLoginStates>(
          listener: (context,state) {
            if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status)
              {
                toastFlutter(msg: state.loginModel.message,color: Colors.green);
                CacheHelper.saveData(key: 'LoginPass', value: state.loginModel.data.token);
                navigatorAndFinish(context, ShopLayout());

              }else
              {
                toastFlutter(msg: state.loginModel.message,color: Colors.red);


              }
            }
          },
          builder: (context,state) {
            var cubit = LoginShopCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style:
                          TextStyle(fontSize: 30.0,),
                        ),

                        Text(
                          "Register Now and Get Offers",
                          style:
                          TextStyle(fontSize: 18.0,color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfiled(
                          controllers: nameController,
                          validate: (value){

                            if (value!.isEmpty) {
                              return "name Must not Be empty ";
                            }
                            return null;
                          },
                          keyboard: TextInputType.text,
                          labeltext: "Name",


                          preicon: Icons.person,


                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfiled(
                          controllers: emailController,
                          validate: (value){

                            if (value!.isEmpty) {
                              return "Email Must not Be empty ";
                            }
                            return null;
                          },
                          keyboard: TextInputType.emailAddress,
                          labeltext: "Email",


                          preicon: Icons.email_outlined,


                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfiled(
                          controllers: phoneController,
                          validate: (value){

                            if (value!.isEmpty) {
                              return "phone Must not Be empty ";
                            }
                            return null;
                          },
                          keyboard: TextInputType.phone,
                          labeltext: "Phone",


                          preicon: Icons.phone,


                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfiled(
                            controllers: passwordController,
                            onSubmit: (value){
                              // if (formKey.currentState!.validate()) {
                              //   LoginShopCubit.get(context).userLogin(email: con_mail.text, password: con_pass.text);
                              // }
                            },
                            validate: (value){

                              if (value!.isEmpty) {
                                return "password must not be empty";
                              }
                              return null;
                            },
                            keyboard: TextInputType.visiblePassword,
                            labeltext: "Password ",
                            needpassicon: true,
                            obscureTexts: cubit.isPassword,
                            preicon: Icons.lock_outline_rounded,
                            sufffun: (){

                              cubit.changeSecure();


                            }

                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultbutton(
                              background_color: defaultColor,

                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginShopCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text ,
                                    phone:phoneController.text ,
                                  );
                                }
                              },
                              text: "Register",
                              borderRadius: 10.0),
                          fallback: (context) =>Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
