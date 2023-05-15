import 'package:emart_seller/controller/order_controller.dart';
import 'package:emart_seller/views/order_screen/components/order_place.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../widgets/our_button.dart';

class OrderDetails extends StatefulWidget {

  final dynamic data;

  const OrderDetails({Key? key,this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.confirmed.value = widget.data['order_on_delivery'];
    controller.confirmed.value = widget.data['order_delivery'];
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back,color: darkGrey,),
          ),
          title: boldText(text: "Orders Details",color: fontGrey,size: 16.0),
        ),
         bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,
              onPress: (){
                controller.confirmed(true);
                controller.changeStatus(title: "order_confirmed", status: true, docID: widget.data.id);
              },
              title: "Confirm Order",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                boldText(text: "Order Status",color: fontGrey,size: 16.0),
                10.heightBox,
                Visibility(
                  visible: controller.confirmed.value,
                  // visible: false,
                  child: Column(
                    children: [
                    SwitchListTile(value: true, onChanged: (value){},activeColor: green,title: boldText(text: "Placed",color: fontGrey),),
                    SwitchListTile(value: controller.confirmed.value, onChanged: (value){controller.confirmed.value = value;},activeColor: green,title: boldText(text: "Confirmed",color: fontGrey),),
                    SwitchListTile(value: controller.onDelivery.value, onChanged: (value){controller.onDelivery.value = value;controller.changeStatus(title: "order_on_delivery", status: value, docID: widget.data.id);}, activeColor: green, title: boldText(text: "on Delivery",color: fontGrey),),
                    SwitchListTile(value: controller.delivered.value, onChanged: (value){controller.delivered.value = value;controller.changeStatus(title: "order_delivered", status: value, docID: widget.data.id);},activeColor: green,title: boldText(text: "Delivered",color: fontGrey),),
                    ],
                  ).box.padding(EdgeInsets.all(8)).roundedSM.shadowSm.white.make(),
                ),
                10.heightBox,
                Column(
                  children: [
                    10.heightBox,
                    orderPlaceDetails(
                      title1: "Order Code",
                      title2: "Shipping Method",
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                    ),
                    orderPlaceDetails(
                      title1: "Order Date",
                      title2: "Payment Method",
                      d1: intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate())),
                      // d1: DateTime.now(),
                      d2: "${widget.data['payment_method']}",
                    ),
                    orderPlaceDetails(
                      title1: "Payment Status",
                      title2: "Delivery Status",
                      d1: "Unpaid",
                      d2: "Order Placed",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(text: "Shipping Address",color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by_city']}".text.make(),
                              "${widget.data['order_by_state']}".text.make(),
                              "${widget.data['order_by_phone']}".text.make(),
                              "${widget.data['order_by_postal_code']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               boldText(text: "Total Amount",color: purpleColor),
                               boldText(text: "Rs: ${widget.data['total_amount']}",color: red,size: 16.0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ).box.roundedSM.shadowSm.white.make(),
                10.heightBox,
                boldText(text: "Ordered Products",color: fontGrey,size: 16.0),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                      controller.orders.length,
                    (index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: "${controller.orders[index]['title']}",
                          title2: "Rs: ${controller.orders[index]['tPrice']}",
                          d1: "${controller.orders[index]['qty']}x",
                          d2: "Refundable",
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(controller.orders[index]['color']) ,
                            )
                        ),
                        // const Divider(thickness: 2,),
                      ],
                    );
                  }).toList(),
                ).box.shadowLg.p8.white.roundedSM.make(),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
