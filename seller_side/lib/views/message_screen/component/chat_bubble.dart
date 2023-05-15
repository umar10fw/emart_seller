


import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';

Widget chatBubble(){
    return  Directionality(
      // textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
      
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          color: purpleColor,
            // color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "${data["msg"]}".text.white.size(16).make(),
            normalText(text: "Your message here..."),
            5.heightBox,
            // "${time}".text.size(12).color(whiteColor.withOpacity(0.5)).make(),
            normalText(text: "10:10 PM"),
          ],
        ),
      // ) : Container(
      //   padding: const EdgeInsets.all(12),
      //   margin: const EdgeInsets.only(bottom: 8),
      //   decoration: BoxDecoration(
      //       color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
      //       borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(20),
      //         topRight: Radius.circular(20),
      //         bottomRight: Radius.circular(20),
      //       )
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       "${data["msg"]}".text.white.size(16).make(),
      //       5.heightBox,
      //       "${time}".text.size(12).color(whiteColor.withOpacity(0.5)).make(),
      //     ],
      //   ),
      // ),
    )
    );
}
