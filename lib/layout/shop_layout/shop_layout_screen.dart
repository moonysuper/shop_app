import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/modules/shop_app/carts/carts_screen.dart';
import 'package:shopapp/modules/shop_app/search/search_screen.dart';
import 'package:shopapp/shared/components/components.dart';



class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state) {},
      builder: (context,state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text('Marketo'),
            actions: [
              IconButton(onPressed: (){
                navigatorTo(context, SearchScreen());
              }, icon:Icon(Icons.search)),
              IconButton(onPressed: (){
                navigatorTo(context, CartsScreen());
              }, icon:Icon(Icons.shopping_cart)),
            ],

          ),
          body:cubit.shopScreen[cubit.currentIndex] ,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: Colors.white
              )
            ),
            child: CurvedNavigationBar(
              height: 50,
              backgroundColor: Colors.transparent,
              color: Colors.brown,
              animationCurve: Curves.easeInBack,
              items: <Widget>[
                  Icon(Icons.home, size: 30),
                  Icon(Icons.category_sharp, size: 30),
                  Icon(Icons.favorite, size: 30),
                  Icon(Icons.settings, size: 30),
                             ],
              onTap: (index){
                cubit.changerBottom(index);
              },
              index: cubit.currentIndex,
            ),
          )
        );
      },
    );
  }
}
