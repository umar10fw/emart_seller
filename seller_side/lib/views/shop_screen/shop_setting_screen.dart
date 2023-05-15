import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_widget.dart';

class ShopSetting extends StatelessWidget {
  const ShopSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSetting,size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(onPressed: () async {

                  controller.isLoading(true);
                  await controller.updateShop(
                    shopname: controller.shopNameController.text,
                    shopaddress: controller.shopAddressController.text,
                    shopmobile: controller.shopMobileController.text,
                    shopwebsite: controller.shopWebsiteController.text,
                    shopdesc: controller.shopDescController.text,
                   );
                  VxToast.show(context, msg: "Updated");
                   }, child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              customTextField(label: shop,hint: nameHint,controller: controller.shopNameController),
              10.heightBox,
              customTextField(label: address,hint: shopAddressHint,controller: controller.shopAddressController),
              10.heightBox,
              customTextField(label: mobile,hint: shopMobileHint,controller: controller.shopMobileController),
              10.heightBox,
              customTextField(label: webSite,hint: shopWebsiteHint,controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(isDesc: true,label: description,hint: shopDecHint,controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
