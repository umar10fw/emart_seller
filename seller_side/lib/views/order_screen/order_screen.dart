import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/order_screen/order_details.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

import '../../controller/order_controller.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(OrdersController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: boldText(text: orders,color: fontGrey, size: 16.0),
        actions: [
          Center(child: normalText(text: intl.DateFormat().add_yMd().format(DateTime.now()),color: purpleColor)),
          10.widthBox,
        ],
      ),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                   (index) {
                      var time = data[index]['order_date'].toDate();
                      return  ListTile(
                        onTap: (){
                          Get.to(()=> OrderDetails(
                            data: data[index],
                          ));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        // leading: Image.asset(imgProduct,width: 100, height: 100, fit: BoxFit.cover,),
                        title: boldText(text: "${data[index]['order_code']}",color: purpleColor),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,color: fontGrey,),
                                10.widthBox,
                                boldText(text: intl.DateFormat().add_yMd().format(time),color: fontGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.payment,color: fontGrey,),
                                10.widthBox,
                                boldText(text: unpaid,color: red),
                              ],
                            )
                          ],
                        ),
                        trailing: boldText(text: "Rs: ${data[index]["total_amount"]}",color: purpleColor,size: 16.0),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                   }
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
