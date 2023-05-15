import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/services/firestore_services.dart';
import 'package:emart_seller/views/product_screen/product_details.dart';
import 'package:emart_seller/views/widgets/dashboard_button.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: dashboard,color: fontGrey, size: 16.0),
        actions: [
          Center(child: normalText(text: intl.DateFormat().add_yMd().format(DateTime.now()),color: purpleColor)),
          10.widthBox,
        ],

      ),

      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
           return loadingIndicator();
          }else{
            var data = snapshot.data!.docs;
            data = data.sortedBy((a, b) => b['p_wishlist'].length.compareTo(a['p_wishlist'].length));

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context, title: products, count: "${data.length}",icon: icProducts),
                        dashboardButton(context, title: orders, count: "75",icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context, title: rating, count: "60",icon: icStar),
                        dashboardButton(context, title: totalSale, count: "15",icon: icProducts),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular,color: fontGrey,size: 16.0),
                    20.heightBox,
                    ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(
                          data.length, (index) => ListTile(
                        onTap: (){
                          Get.to(()=> ProductDetails(data: data[index],));
                        },
                        leading: Image.network(data[index]['p_imgs'][0],width: 100, height: 100, fit: BoxFit.cover,),
                        title: boldText(text: "${data[index]['p_name']}",color: fontGrey),
                        subtitle: normalText(text: "Rs: ${data[index]['p_price']}",color: darkGrey),
                      )),
                    )


                  ],
                ),
              ),
            );
          }
        }
      ),
    );
  }
}
