import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_app/login_model.dart';
import 'package:shopapp/modules/shop_app/login/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';


class LoginShopCubit extends Cubit<ShopLoginStates>
{
  LoginShopCubit() : super(ShopLoginInitialState());
  static LoginShopCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;
   void userLogin({
  required String email,
  required String password,
    }){
     emit(ShopLoginLoadingState());
      dio_helper.postdata(url: Login, data: {
        "email":email,
        "password":password,
}).then((value){
        print(value.data);
        loginModel =  ShopLoginModel.fromJson(value.data);
        token = loginModel!.data.token;
        print(loginModel!.status);
        print(loginModel!.message);
  emit(ShopLoginSuccessState(loginModel!));
      }).catchError((error){
        print(error.toString());
        emit(ShopLoginErrorState(error.toString()));
        
      });
   }

   bool isPassword = true;

   void changeSecure(){
     isPassword = !isPassword;
     emit(ShopLoginChangeSecureState());
   }

 // ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }){
    emit(ShopLoginLoadingState());
    dio_helper.postdata(url: Register, data: {
      "name":name,
      "email":email,
      "phone":phone,
      "password":password,
    }).then((value){
      print(value.data);
      loginModel =  ShopLoginModel.fromJson(value.data);
      token = loginModel!.data.token;
      print(loginModel!.status);
      print(loginModel!.message);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));

    });
  }
}