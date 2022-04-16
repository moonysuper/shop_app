

import 'package:shopapp/models/shop_app/favorites_model.dart';
import 'package:shopapp/models/shop_app/login_model.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopChangerBottomState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopChangeFavoritesState extends ShopState {}

class ShopSuccessFavoritesState extends ShopState {
  final FavoritesModel favoritesModel;

  ShopSuccessFavoritesState(this.favoritesModel);
}

class ShopErrorFavoritesState extends ShopState {}

class ShopLoadingGetFavoritesState extends ShopState {}

class ShopSuccessGetFavoritesState extends ShopState {}

class ShopErrorGetFavoritesState extends ShopState {}

class ShopLoadingGetUserDataState extends ShopState {}

class ShopSuccessGetUserDataState extends ShopState {}

class ShopErrorGetUserDataState extends ShopState {}

class ShopLoadingUpdateUserDataState extends ShopState {}

class ShopSuccessUpdateUserDataState extends ShopState {
  final ShopLoginModel usersModel;

  ShopSuccessUpdateUserDataState(this.usersModel);
}

class ShopErrorUpdateUserDataState extends ShopState {}

class ShopLoadingSearchState extends ShopState {}

class ShopSuccessSearchState extends ShopState {}

class ShopErrorSearchState extends ShopState {}

class ShopLoadingCartState extends ShopState {}

class ShopSuccessCartState extends ShopState {}

class ShopErrorCartState extends ShopState {}

class ShopLoadingCartItemState extends ShopState {}

class ShopSuccessCartItemState extends ShopState {}

class ShopErrorCartItemState extends ShopState {}

