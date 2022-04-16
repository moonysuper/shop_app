import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';

import 'package:shopapp/shared/components/components.dart';

import 'package:shopapp/shared/style/colors.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
     listener: (context,state) {
       if(state is ShopSuccessFavoritesState)
         {
           if(!state.favoritesModel.status)
             toastFlutter(msg: state.favoritesModel.message, color: Colors.red);
         }
     },
     builder: (context,state) {
       var cubit = ShopCubit.get(context);

       return ConditionalBuilder(condition: cubit.homeModel != null && cubit.categoriesModel != null,
           builder: (context) => homeBuilder(cubit.homeModel,cubit.categoriesModel,cubit,context),
         fallback: (context) => Center(child: CircularProgressIndicator()),
       );
     },
    );

  }

  Widget homeBuilder(model,cate,cubit,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CarouselSlider(items: model.data!.banners.map<Widget>((e) => Image(image: NetworkImage('${e.image}'),
        width: double.infinity,
        fit: BoxFit.fill,
      ), ).toList(),
          options: CarouselOptions(
        height: 250,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(seconds: 1),
        autoPlayCurve: Curves.easeInBack,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1.0,

      ),
      ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24),),
              Container(
                height: 150,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index) => buildCategories(cate.data.data[index]),
                  separatorBuilder: (context , index) => SizedBox(width: 8,),
                  itemCount: cate.data.data.length),
              ),
              SizedBox(height: 20,),
              Text('Products',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            ],
          ),
        ),

        Container(
          color: Colors.grey[300],
          child: GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.7,
            physics: NeverScrollableScrollPhysics(),
            children:
              List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index],cubit,context)),

          ),
        ),
      ],
    ),
  );

  Widget buildGridProduct(model,cubit,context) =>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Stack(
            children:[
              Image(image: NetworkImage(model.image),
                width: double.infinity,
                 height: 200,
            ),
              if(model.price < model.oldPrice)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: Text('Discount',style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,

                ),),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold,

                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Text('${model.price}',style: TextStyle(color: defaultColor),)),
                    SizedBox(width: 10,),
                    if(model.price < model.oldPrice)
                    Expanded(
                      child: Text('${model.oldPrice}',style: TextStyle(color: Colors.black,
                          decoration: TextDecoration.lineThrough),
                      ),
                    ),
                   // Spacer(),
                    
                    IconButton(
                        onPressed: (){
                          cubit.getFavorites(model.id);

                        },
                        icon: Icon(Icons.favorite),
                        color: cubit.inFav![model.id] ? Colors.redAccent :Colors.grey,
                        iconSize: 30,
                    ),
                    IconButton(
                        onPressed: (){
                        cubit.getCart(model.id);

                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                        color:Colors.grey,
                        iconSize: 30,
                    ),
                  ],
                ),
              ],
            ),
          )

      ],
    ),
  );

  Widget buildCategories(cate) => Container(
    width: 150,
    height: 150,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(image: NetworkImage(cate.image),
          height: 140,
          width: 150,
          fit: BoxFit.cover,
        ),
        Container(
            color: Colors.black.withOpacity(0.8),
            width: 150,

            child: Text('${cate.name}',
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    ),
  );

}
