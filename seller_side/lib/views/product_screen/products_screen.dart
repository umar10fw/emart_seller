import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/views/product_screen/add_prouct.dart';
import 'package:emart_seller/views/product_screen/product_details.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

import '../../controller/products_controller.dart';
import '../../services/firestore_services.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          controller.popularCategoryList();
          Get.to(()=> const AddProducts());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: products,color: fontGrey, size: 16.0),
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
          } else{
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                     data.length,
                    (index) => Card(
                    child: ListTile(
                      onTap: (){
                        Get.to(()=> ProductDetails(
                          data: data[index],
                        ));
                      },
                      leading: Image.network(data[index]["p_imgs"][0],width: 100, height: 100, fit: BoxFit.cover,),
                      title: boldText(text: "${data[index]["p_name"]}",color: fontGrey),
                      subtitle: Row(
                        children: [
                          boldText(text: "Rs: ${data[index]["p_price"]}",color: purpleColor),
                          10.widthBox,
                          boldText(text: data[index]['is_feature'] == true ? "Featured" : '',color: green),
                        ],
                      ),
                      trailing: VxPopupMenu(
                        menuBuilder: ()=> Column(
                          children: List.generate(popMenuTitles.length, (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(popMenuIcons[index],
                                  color: data[index]['featured_id'] == currentUser!.uid && index == 0
                                  ? green
                                  : darkGrey,
                                ),
                                10.widthBox,
                                normalText(text:
                                data[index]['featured_id'] == currentUser!.uid && index == 0
                                ? "Removed Featured"
                                : popMenuTitles[index],color: darkGrey),

                              ],
                            ).onTap(() {
                              switch(index){
                                case 0:
                                  if(data[index]['is_feature'] == true){
                                    controller.removeFeatured(data[index].id);
                                    VxToast.show(context, msg: "Removed");
                                  }else {
                                    controller.addFeatured(data[index].id);
                                    VxToast.show(context, msg: "Added");
                                  }

                                  break;
                                case 1:
                                  break;
                                case 2:
                                  controller.removeProducts(data[index].id);
                                  VxToast.show(context, msg: "Product Removed");
                                  break;
                               default:
                              }
                            }),
                          )),
                        ).box.roundedSM.white.width(200).make(),
                        clickType: VxClickType.singleClick,
                        child: const Icon(Icons.more_vert_rounded),
                      ),
                    ),
                  )
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
