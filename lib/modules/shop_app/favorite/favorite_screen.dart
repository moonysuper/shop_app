import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState ,
          builder:(context) => ListView.separated(itemBuilder: (BuildContext context, int index) => buildFavItem(cubit.favModel!.data!.data![index],cubit),
            separatorBuilder: (BuildContext context, int index) => myDivider(),
            itemCount: cubit.favModel!.data!.data!.length,

          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
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
              Text(model.product.name,maxLines: 2,overflow: TextOverflow.ellipsis,),

              Row(

                children: [
                  Text('${model.product.price}',style: TextStyle(color: defaultColor),),
                  SizedBox(width: 10,),
                  if(model.product.price < model.product.oldPrice)
                    Text('${model.product.oldPrice}',style: TextStyle(color: Colors.black,
                        fontSize: 14,decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      cubit.getFavorites(model.product.id);

                    },
                    icon: Icon(Icons.favorite),
                    color: cubit.inFav![model.product.id] ? Colors.redAccent :Colors.grey,
                    iconSize: 30,
                  )
                ],
              ),
            ],
          ),
        )

      ],
    ),
  );
}
