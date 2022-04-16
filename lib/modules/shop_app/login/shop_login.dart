import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/shop_layout_screen.dart';
import 'package:shopapp/modules/shop_app/login/cubit/cubit.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/modules/shop_app/register/shop_register.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/style/colors.dart';

class ShopLogin extends StatelessWidget {
   ShopLogin({Key? key}) : super(key: key);

  var con_mail = TextEditingController();
  var con_pass = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginShopCubit(),
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
          return Scaffold(
            appBar: AppBar(

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style:
                          TextStyle(fontSize: 30.0,),
                        ),

                        Text(
                          "Get Hot Offers",
                          style:
                          TextStyle(fontSize: 18.0,color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfiled(
                            controllers: con_mail,
                            validate: (value){

                              if (value!.isEmpty) {
                                return "Please Enter Valid Email ";
                              }
                              return null;
                            },
                            keyboard: TextInputType.emailAddress,
                            labeltext: "Email Address ",


                            preicon: Icons.mail_outline_outlined,


                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultformfiled(
                            controllers: con_pass,
                            onSubmit: (value){
                              if (formKey.currentState!.validate()) {
                                LoginShopCubit.get(context).userLogin(email: con_mail.text, password: con_pass.text);
                              }
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
                                  LoginShopCubit.get(context).userLogin(email: con_mail.text, password: con_pass.text);
                                }
                              },
                              text: "login",
                              borderRadius: 10.0),
                          fallback: (context) =>Center(child: CircularProgressIndicator()),
                         ),

                        SizedBox(
                          height: 10.0,
                        ),

                        Row(
                          children: [
                            Text("Don't have account?"),
                            TextButton(
                              onPressed: () {
                                navigatorTo(context, RegisterScreen());
                              },
                              child: Text("Register Now"),
                            ),
                          ],
                        )
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
