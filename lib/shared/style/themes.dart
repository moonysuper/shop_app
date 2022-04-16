import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:shopapp/shared/style/colors.dart';


ThemeData darkTheme = ThemeData(
  fontFamily: "Janah",
    primarySwatch: defaultColor,
    textTheme: TextTheme(
        body1: TextStyle(
          color:Colors.white,
        )
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      backgroundColor: HexColor('#333739'),
      unselectedItemColor: Colors.white,
    ),
    scaffoldBackgroundColor: HexColor('#333739'),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        color: HexColor('#333739'),
        elevation: 0,


        backwardsCompatibility: false,
        titleTextStyle:TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ) ,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black,

        )
    )
);
ThemeData lightTheme = ThemeData(
    fontFamily: "Janah",
    primarySwatch: defaultColor,

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        color: Colors.white,
        elevation: 0,
        backwardsCompatibility: false,
        titleTextStyle:TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ) ,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,

        )
    )
);