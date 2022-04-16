import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/colors.dart';


class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state) {
      },
      builder: (context,state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(title:Text('Cart'),),
          body: Column(
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit.cartsModel!.data!.cartItems!.length > 0,
                  builder:(context) => ListView.separated(itemBuilder: (BuildContext context, int index) => buildFavItem(cubit.cartsModel!.data!.cartItems![index],cubit),
                    separatorBuilder: (BuildContext context, int index) => myDivider(),
                    itemCount: cubit.cartsModel!.data!.cartItems!.length,

                  ),
                  fallback: (context) => Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart,size: 90,),
                      Text('Your Cart is Empty',style: TextStyle(
                        fontSize: 30,fontWeight: FontWeight.bold
                      ),)
                    ],
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text('Total Prices:${cubit.totalPrices}'),
                    SizedBox(width: 10,),
                    Expanded(
                      child: defaultbutton(function: (){
                        toastFlutter(msg: "Soon :)", color: Colors.green);
                      },
                          text: "BuyNow"),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: defaultbutton(function: (){

                      },
                          text: "Empty",background_color: Colors.red),
                    ),


                  ],
                ),
              )

            ],
          ),
        );
      },
    );

  }

  Widget buildFavItem(model,cubit) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(

      children: [
        Container(
          width: 120,
          height: 120,
          child: Stack(
              children:[
                Image(image: NetworkImage(model.product.image),
                  width: 120,
                  height: 120,
                  fit: BoxFit.fill,
                ),
                if(model.product.price < model.product.oldPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text('Discount',style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,

                    ),),
                  ),
              ]
          ),

        ),
        SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(model.product.name,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 18),),

              Row(

                children: [
                  Text('${model.product.price}',style: TextStyle(color: defaultColor,fontSize: 18),),
                  SizedBox(width: 10,),
                  if(model.product.price < model.product.oldPrice)
                    Text('${model.product.oldPrice}',style: TextStyle(color: Colors.black,
                        fontSize: 8,decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      cubit.getFavorites(model.product.id);

                    },
                    icon: Icon(Icons.favorite),
                    color: cubit.inFav![model.product.id] ? Colors.redAccent :Colors.grey,
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: (){
                      cubit.getCart(model.product.id);

                    },
                    icon: Icon(Icons.delete),
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
}
