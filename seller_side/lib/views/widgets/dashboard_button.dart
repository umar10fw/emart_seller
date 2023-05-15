


import 'package:emart_seller/views/widgets/text_widget.dart';

import '../../const/const.dart';

Widget dashboardButton(context,{title, count,icon}){

  var size = MediaQuery.of(context).size;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          boldText(text: title,size: 16.0),
          boldText(text: count,size: 20.0)
        ],
      ),
      Image.asset(icon, width: 40, color: white,),
    ],
  ).box
      .color(purpleColor)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}