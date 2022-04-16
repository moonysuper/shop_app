//import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';



class CubitApp extends Cubit<AppStates>
{
  CubitApp() : super(AppInitialState());

  static CubitApp get(context) => BlocProvider.of(context);
  var theme = true;
  int creent = 0;
  bool isshow = false;
  IconData iconfbutton = Icons.edit;

  List<String> names = [
    "News task",
    "Done",
    "Archive",
  ];
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivetasks = [];




  void changer({
  required bool isshow,
  required IconData iconfbutton,
}) {
    this.isshow = isshow;
    this.iconfbutton = iconfbutton;
    emit(AppChangerState());
  }

}