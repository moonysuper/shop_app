
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit/states.dart';
import 'package:shopapp/models/shop_app/categories_model.dart';
import 'package:shopapp/shared/components/components.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state) {},
      builder: (context,state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) =>buildCateItem(ShopCubit.get(context).categoriesModel!.data!.data![index],context) ,
            separatorBuilder: (context,index) => myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length);
      },
    );
  }
  Widget buildCateItem(DataModel cate,context) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      child: Row(
        children: [
          Image(image: NetworkImage('${cate.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 20,),
          Text('${cate.name}',style: TextStyle(fontSize: MediaQuery.of(context).size.width/25,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    ),
  );
}
