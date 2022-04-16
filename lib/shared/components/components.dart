import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';






// Button components
Widget defaultbutton({
   double width = double.infinity,
   Color background_color =Colors.blue,
   Color text_color =Colors.white,
   bool  isuppercase = true,
    double borderRadius =0.0,
   required var function ,
   required String text ,

}) =>
    Container(

      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: background_color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          "${isuppercase ? text.toUpperCase() : text}",
          style: TextStyle(color: text_color),
        ),
      ),
    );

// TextFormField components

Widget defaultformfiled({
  required TextInputType keyboard ,
  required String labeltext,
  required TextEditingController controllers ,
  IconData? preicon,
  var sufffun,
  bool obscureTexts =false,
  bool needpassicon =false,
  required var validate,
   var  ontap,
   var  onchange,
   var  onSubmit,
}) => TextFormField(
  onTap: ontap,
  onFieldSubmitted: onSubmit,
  onChanged: onchange,
  validator: validate,
  controller:controllers ,
  keyboardType: keyboard,
  obscureText: obscureTexts,
  decoration: InputDecoration(
    labelText: "$labeltext",
    border: OutlineInputBorder(),
    prefixIcon: Icon(preicon),
          suffixIcon: needpassicon
              ? IconButton(
                  icon: obscureTexts
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.visibility_off),
                  onPressed:sufffun,
                )
              : null),




);



Widget myDivider() => Container(color: Colors.grey,width: double.infinity,height: 1,);




void navigatorTo(context,Widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget
  ),
);
void navigatorAndFinish(context,Widget) =>  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => Widget
  ),(route) => false,
);

void toastFlutter({
  required String msg,
  required Color color,
}) =>  Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: color,
textColor: Colors.white,
fontSize: 16.0,
);