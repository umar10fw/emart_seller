import 'package:emart_seller/views/product_screen/components/product_dropown.dart';
import 'package:emart_seller/views/product_screen/components/prouct_images.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../../controller/products_controller.dart';
import '../widgets/text_widget.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductsController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: boldText(text: "Add Product",color: white,size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(onPressed: () async {
                  controller.isLoading(true);
                  await controller.uploadImages();
                  await controller.uploadProducts(context);
                  Get.back();

                  }, child: boldText(text: "Save",color: white)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(hint: "eg.BMW",label: "Product Name",controller: controller.pNameController),
                  10.heightBox,
                  customTextField(hint: "eg.\$ 100.0",label: "Price",controller: controller.pPriceController),
                  10.heightBox,
                  customTextField(hint: "eg. 20",label: "Quantity",controller: controller.pQuantityController),
                  10.heightBox,
                  customTextField(hint: "eg.Nice product",label: "Description",isDesc: true,controller: controller.pDescController),
                  10.heightBox,
                  productDropdown("Category", controller.categoryList, controller.categoryValue,controller),
                  10.heightBox,
                  productDropdown("Subcategory", controller.subcategoryList, controller.subcategoryValue,controller),
                  10.heightBox,
                  boldText(text: "Choose product images"),
                  5.heightBox,
                  normalText(text: "First image will be your display image",color: lightGrey),
                  5.heightBox,
                  Obx(
                    ()=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3, (index) => controller.pImagesList[index] != null
                          ? Image.file(controller.pImagesList[index],width: 100,).onTap(() {
                            controller.pickImages(index, context);
                      })
                          : productImages(label: "${index + 1}").onTap(() {
                        controller.pickImages(index, context);
                      })),
                    ),
                  ),
                  10.heightBox,
                  boldText(text: "Choose product colors"),
                  10.heightBox,
                  Obx(
                    ()=> Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: List.generate(10, (index) =>
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox().color(Vx.randomPrimaryColor).roundedFull.size(50,50).make().onTap(() {
                                controller.selectedColorIndex.value = index;
                              }),
                              controller.selectedColorIndex.value == index ?
                              const Icon(Icons.done,color: white,) :
                                  const SizedBox()
                            ],
                          )),

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
