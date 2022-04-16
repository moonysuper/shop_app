import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/style/themes.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'layout/news_layout/cubit/cubit.dart';
import 'layout/shop_layout/cubit/cubit.dart';
import 'layout/shop_layout/shop_layout_screen.dart';
import 'modules/shop_app/login/shop_login.dart';
import 'modules/shop_app/on_boarding/on_boarding.dart';
import 'shared/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dio_helper.init();
  await CacheHelper.init();
   bool? themea =CacheHelper.getData(key: "isDark");
   bool? onBoarding =CacheHelper.restoreData(key: "onBoarding");
    token =CacheHelper.restoreData(key: "LoginPass");
  Widget widget;

  if(themea == null)
    {
      themea = true;
    }
  print(onBoarding);
  // if(onBoarding == null)
  // {
  //   onBoarding = false;
  // }
  //
  if(onBoarding == true)
    {
      if(token != null)
        {
          widget = ShopLayout();
        }else
          widget = ShopLogin();
    }
  else
    widget = OnBoardingScreen();
  runApp(MyApp(themea,widget));
}

class MyApp extends StatelessWidget {
  bool? themea;
  Widget widget;
  MyApp(this.themea,this.widget);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>CubitApp(),),
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness(),),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesModel()..getFav()..getUserData()..getCartItem(),)

      ],
      child: BlocConsumer<CubitApp,AppStates>(
        listener: (context,state) {},
        builder: (context,state) {

          return MaterialApp(
            theme:lightTheme,
            darkTheme: darkTheme,
            themeMode: CubitApp.get(context).theme ? ThemeMode.light :ThemeMode.dark  ,
            debugShowCheckedModeBanner: false,
            home: widget,
          );
        },
      ),
    );
  }


}
