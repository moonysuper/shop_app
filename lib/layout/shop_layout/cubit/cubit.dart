import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_app/cart_model.dart';
import 'package:shopapp/models/shop_app/carts_model.dart';
import 'package:shopapp/models/shop_app/categories_model.dart';
import 'package:shopapp/models/shop_app/favmodel.dart';
import 'package:shopapp/models/shop_app/favorites_model.dart';
import 'package:shopapp/models/shop_app/home_model.dart';
import 'package:shopapp/models/shop_app/login_model.dart';
import 'package:shopapp/models/shop_app/search_model.dart';
import 'package:shopapp/modules/shop_app/categories/categories_screen.dart';
import 'package:shopapp/modules/shop_app/favorite/favorite_screen.dart';
import 'package:shopapp/modules/shop_app/products/products_screen.dart';
import 'package:shopapp/modules/shop_app/settings/settings.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import 'package:flutter/material.dart';

import 'package:shopapp/layout/shop_layout/cubit/states.dart';


class ShopCubit extends Cubit<ShopState>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> shopScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changerBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangerBottomState());
  }


  HomeModel? homeModel;
  Map<int,bool> inFav = {};
  Map<int,bool> inCart = {};
  getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    dio_helper.getData(url: Home,auth: token).then((value){
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        inFav.addAll({
          element.id : element.inFavorites
        });
      });
      homeModel!.data!.products.forEach((element) {
        inCart.addAll({
          element.id : element.inCart
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });

  }

  CategoriesModel?  categoriesModel;
  
   void getCategoriesModel(){
    
    dio_helper.getData(url: Categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

   late FavoritesModel favoritesModel;
  
  void getFavorites(int productId)
  {
    inFav[productId] = !inFav[productId]!;

    emit(ShopChangeFavoritesState());
    dio_helper.postdata(url: Favorites, data: {'product_id':productId },auth: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if(!favoritesModel.status)
        inFav[productId] = !inFav[productId]!;
      else
        getFav();

      emit(ShopSuccessFavoritesState(favoritesModel));
    }).catchError((error){
      inFav[productId] = !inFav[productId]!;
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }



  FavModel?  favModel;

  void getFav(){
    emit(ShopLoadingGetFavoritesState());
    dio_helper.getData(url: Favorites,auth: token).then((value) {
      favModel = FavModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel?  usersModel;

  void getUserData(){
    emit(ShopLoadingGetUserDataState());
    dio_helper.getData(url: Profile,auth: token).then((value) {
      usersModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit(ShopLoadingUpdateUserDataState());
    dio_helper.updateData(url: Update_Profile,
        auth: token, data: {
          'name':name,
          'email':email,
          'phone':phone,
        }).then((value) {
      usersModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState(usersModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }

  SearchModel? searchModel;

  void search(String data){
    emit(ShopLoadingSearchState());
    dio_helper.postdata(url: Search, auth: token,data: {'text':data}).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorSearchState());
    });

  }

  CartModel? cartModel;
  void getCart(int productId)
  {

    inCart[productId] = !inCart[productId]!;

    emit(ShopLoadingCartState());
    dio_helper.postdata(url: Carts, data: {'product_id':productId },auth: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      if(!cartModel!.status)
        inFav[productId] = !inFav[productId]!;
      else
        getCartItem();
      emit(ShopSuccessCartState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCartState());
    });
  }


  CartsItems? cartsModel;
  double totalPrices = 0;
   getCartItem(){
     totalPrices = 0;
    emit(ShopLoadingCartItemState());
    dio_helper.getData(url: Carts,auth: token).then((value){
      print('.//////////////////////////////////////////////////////');
      cartsModel = CartsItems.fromJson(value.data);
      cartsModel!.data!.cartItems!.forEach((element) {
        totalPrices = totalPrices + element.product!.price;
      });

      print(cartsModel!.data!.cartItems![0].product!.name);
      emit(ShopSuccessCartItemState());
    }).catchError((error){
      print(error.toString());
          emit(ShopErrorCartItemState());
    });
  }

}