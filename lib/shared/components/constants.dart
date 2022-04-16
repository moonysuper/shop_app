import 'package:shopapp/modules/shop_app/login/shop_login.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';


void singOut(context)
{
  CacheHelper.removeData(key: 'LoginPass').then((value){
    navigatorAndFinish(context, ShopLogin());
  }).catchError((error){
    print(error.toString());
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

 String token = '';