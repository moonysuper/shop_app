
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/news_layout/cubit/states.dart';

import 'package:shopapp/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() :super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0 ;





  List<BottomNavigationBarItem> BottomItem = [
  BottomNavigationBarItem(icon: Icon(
    Icons.business,
  ), label: "Business",
  ),
  BottomNavigationBarItem(icon: Icon(
    Icons.sports,
  ), label: "Sports",
  ),
  BottomNavigationBarItem(icon: Icon(
    Icons.science,
  ), label: "Science",
  ),
  BottomNavigationBarItem(icon: Icon(
    Icons.settings,
  ), label: "Settings",
  ),
  ];
void change(int index)
{
  currentindex = index;
  if(index ==1)
    getSport();
  else if(index == 2)
    getSciences();
  emit(NewsBottomNavStates());
}

List<dynamic> business = [];
List<dynamic> Sport = [];
List<dynamic> Sciences = [];
List<dynamic> Search = [];

 void getBusiness(){
   emit(NewsLoadingBusinessStates());
   dio_helper.getData(url: "v2/top-headlines",
     query:{
       "country":"ae",
       "category":"business",
       "apiKey":"9cf46a7a4a084261ad6baaeb6fa78546",
     }, ).then((value) {
       business = value.data["articles"];
       emit(NewsGetBusinessSuccessStates());
   }).catchError((error){
     print(error);
     emit(NewsGetBusinessErrorStates(error.toString()));
   });
 }

  void getSport() {
    emit(NewsLoadingSportStates());
    dio_helper.getData(url: "v2/top-headlines",
      query:{
        "country":"ae",
        "category":"sports",
        "apiKey":"9cf46a7a4a084261ad6baaeb6fa78546",
      }, ).then((value) {
      Sport = value.data["articles"];
      emit(NewsGetSportSuccessStates());
    }).catchError((error){
      print(error);
      emit(NewsGetSportErrorStates(error.toString()));
    });
  }

  void getSciences() {
    emit(NewsLoadingSciencesStates());
    dio_helper.getData(url: "v2/top-headlines",
      query:{
        "country":"ae",
        "category":"science",
        "apiKey":"9cf46a7a4a084261ad6baaeb6fa78546",
      }, ).then((value) {
      Sciences = value.data["articles"];
      emit(NewsGetSciencesSuccessStates());
    }).catchError((error){
      print(error);
      emit(NewsGetSciencesErrorStates(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsLoadingSearchStates());
    dio_helper.getData(url: "/v2/everything",
      query:{
        "q":"$value",
        "apiKey":"9cf46a7a4a084261ad6baaeb6fa78546",
      }, ).then((value) {
      Search = value.data["articles"];
      emit(NewsGetSearchSuccessStates());
    }).catchError((error){
      print(error);
      emit(NewsGetSearchErrorStates(error.toString()));
    });
  }


}