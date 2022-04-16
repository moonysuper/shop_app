import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<ShopCubit,ShopState>(

      listener: (context,state) {},
      builder: (context,state) {

        var cubit = ShopCubit.get(context);
        nameController.text = cubit.usersModel!.data.name;
        emailController.text = cubit.usersModel!.data.email;
        phoneController.text = cubit.usersModel!.data.phone;
        return ConditionalBuilder(
          condition: cubit.usersModel!.data != null ,
          builder:(context) => buildSettingItem(context,state),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
  Widget buildSettingItem(context,state) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if(state is ShopLoadingUpdateUserDataState )
              LinearProgressIndicator(),
            SizedBox(height: 20,),
            CircleAvatar( backgroundColor: defaultColor,radius: 64,  child: CircleAvatar(backgroundImage:NetworkImage(ShopCubit.get(context).usersModel!.data.image),radius: 60,)),
            SizedBox(height: 20,),
            defaultformfiled(keyboard: TextInputType.text,
                labeltext: 'Name',
                controllers: nameController,
                validate: (String value){
                if(value.isEmpty)
                  return 'Name Must Not Be Empty';
                return null;
                },
                preicon: Icons.person,
            ),
            SizedBox(height: 20,),
            defaultformfiled(keyboard: TextInputType.emailAddress,
              labeltext: 'Email Address',
              controllers: emailController,
              validate: (String value){
                if(value.isEmpty)
                  return 'Email Must Not Be Empty';
                return null;
              },
              preicon: Icons.email,
            ),
            SizedBox(height: 20,),
            defaultformfiled(keyboard: TextInputType.phone,
              labeltext: 'Phone',
              controllers: phoneController,
              validate: (String value){
                if(value.isEmpty)
                  return 'Phone Must Not Be Empty';
                return null;
              },
              preicon: Icons.phone,
            ),
            SizedBox(height: 20,),
            defaultbutton(function: (){
              if(formKey.currentState!.validate())
                {
                  ShopCubit.get(context).updateUserData(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text);
                }

            }, text: 'Update',),
            SizedBox(height: 20,),
            defaultbutton(function: (){singOut(context);}, text: 'SingOut',background_color:Colors.red,)


          ],
        ),
      ),
    ),
  );
}
