import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopapp/modules/shop_app/login/shop_login.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingData{
  late final String image;
  late final String title;
  late final String body;

  OnBoardingData({
    required this.image,
    required this.title,
    required this.body,
});

}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  List<OnBoardingData> boarding = [
    OnBoardingData(image:'Asset/images/onbording_1.jpg',title: 'Digital Market',body: "beautiful design and easy by click you can buy you need" ),
    OnBoardingData(image:'Asset/images/onbording_2.PNG',title: 'Online Market',body: 'Open all time ... no wait .. no delay ..Go now'),
    OnBoardingData(image:'Asset/images/onbording_3.PNG',title: 'Support team',body: 'the market have support team available to help you '),
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [
          TextButton(onPressed: (){onBoardingSkip(context);}, child: Text("Skip"))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(child: PageView.builder(
              itemBuilder:(context,index) => pageViewBuilder(boarding[index]),
              itemCount: 3,
              controller: boardingController ,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int num){
                if(num == boarding.length -1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                else
                  {
                    isLast = false;
                  }

              },
            ),),
            SizedBox(height: 30,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5,
                    expansionFactor: 4,
                    dotColor: Colors.grey,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast == true)
                    {
                      onBoardingSkip(context);
                    }else
                  boardingController.nextPage(duration: Duration(
                    milliseconds: 750,
                  ), curve: Curves.easeInBack);
                },child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ) ,

    );
  }

Widget pageViewBuilder(OnBoardingData data) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Image(
        image: AssetImage('${data.image}'),
      ),
    ),
    SizedBox(
      height: 30,
    ),
    Text('${data.title}',style: TextStyle(fontSize: 30.0,fontFamily: 'jannah'),),
    SizedBox(
      height: 20,
    ),
    Text('${data.body}',style: TextStyle(fontSize: 15.0,fontFamily: 'jannah'),),
    SizedBox(
      height: 20,
    ),
  ],
);

}

void onBoardingSkip(context){

  CacheHelper.saveData(key: 'onBoarding', value: true);
  navigatorAndFinish(context,ShopLogin());

}
