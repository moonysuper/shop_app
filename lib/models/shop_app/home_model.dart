class HomeModel{

  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{

   List<HomeDataBanners> banners = [];
   List<HomeDataProducts> products = [];

  HomeDataModel.fromJson(Map<String,dynamic> json){

  json['banners'].forEach((element){
    banners.add(HomeDataBanners.fromJson(element));
  });
  json['products'].forEach((element){
    products.add(HomeDataProducts.fromJson(element));
  });

  }
}

class HomeDataBanners{
  int? id;
  String? image;
  HomeDataBanners.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }


}

class HomeDataProducts{
   late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  late bool inFavorites;
  late bool inCart;

  HomeDataProducts.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}