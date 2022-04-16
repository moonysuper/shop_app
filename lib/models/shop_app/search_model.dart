class SearchModel{
  late bool status;
  late ResultSearch data;

  SearchModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = (json['data'] != null ? ResultSearch.fromJson(json['data']) : null)!;
  }
}

class ResultSearch{
  late int currentPage;
  late List<DataSearch> data = [];

  ResultSearch.fromJson(Map<String,dynamic> json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataSearch.fromJson(element));
    });
  }

}

class DataSearch{
  late int id;
  late String name;
  dynamic price;
  late String image;
  late bool inFavorites;

  DataSearch.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    inFavorites = json['in_favorites'];
  }

}