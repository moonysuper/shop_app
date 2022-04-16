import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/colors.dart';
class SearchScreen extends StatelessWidget {
  var searchController2 = TextEditingController();
  // var cubit = ;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ShopCubit,ShopState>(
          listener: (context,state) {},
           builder: (context,state) {
            return Scaffold(

              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultformfiled(
                        keyboard: TextInputType.text,
                        labeltext: "Search",
                        controllers: searchController2,
                        validate: (String value){
                          if(value.isEmpty)
                          {
                            return "Search must not be empty";
                          }
                          return null;
                        },

                        onchange: (value){
                          ShopCubit.get(context).search(value);
                        },
                        preicon:Icons.search,


                      ),
                    ),

                    if(state is ShopLoadingSearchState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                   if(ShopCubit.get(context).searchModel != null)
                     Expanded(child: buildSearchItem(ShopCubit.get(context).searchModel,ShopCubit.get(context),state)),
                  ],

                ),
              ),
            );
           },

      );
  }
Widget buildSearchItem(model,cubit,state) => ListView.separated(itemBuilder: (context,index)=>builderData(cubit.searchModel!.data!.data[index],cubit),
    separatorBuilder: (context,index) => myDivider(),
    itemCount: model.data.data.length);

Widget builderData(model,cubit) => Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

    children: [

      Container(

        width: 120,

        height: 120,

        child: Stack(

            children:[

              Image(image: NetworkImage(model.image),

                width: 120,

                height: 120,

                fit: BoxFit.fill,

              ),

              // if(model.price < model.oldPrice)

              //   Container(

              //     padding: EdgeInsets.symmetric(horizontal: 5),

              //     color: Colors.red,

              //     child: Text('Discount',style: TextStyle(

              //       fontSize: 8.0,

              //       color: Colors.white,

              //

              //     ),),

              //   ),

            ]

        ),



      ),

      SizedBox(width: 20,),

      Expanded(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            Text(model.name,maxLines: 2,overflow: TextOverflow.ellipsis,),



            Row(



              children: [

                Text('${model.price}',style: TextStyle(color: defaultColor),),

                SizedBox(width: 10,),

                // if(model.price < model.oldPrice)

                //   Text('${model.oldPrice}',style: TextStyle(color: Colors.black,

                //       fontSize: 14,decoration: TextDecoration.lineThrough),

                //   ),

                Spacer(),

                IconButton(

                  onPressed: (){

                    cubit.getFavorites(model.id);



                  },

                  icon: Icon(Icons.favorite),

                  color: cubit.inFav![model.id] ? Colors.redAccent :Colors.grey,

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