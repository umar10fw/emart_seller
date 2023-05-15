import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controller/auth_controller.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/message_screen/message_screen.dart';
import 'package:emart_seller/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../../services/firestore_services.dart';
import '../shop_screen/shop_setting_screen.dart';
import '../widgets/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return Scaffold(
        body: Scaffold(
          backgroundColor: purpleColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: boldText(text: setting, size: 16.0),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => EditProfileScreen(
                       username: controller.snapshotData["vendor_name"],
                      ));
                    },
                    icon: const Icon(Icons.edit)),
                TextButton(
                    onPressed: () async {
                      await Get.find<AuthController>().signOutMethod(context);
                      Get.off(() => const LoginScreenSeller());
                    },
                    child: normalText(text: logout)),
              ],
            ),
         body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circleColor: white);
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Column(
              children: [
                ListTile(
                  leading:
                      controller.snapshotData['imageUrl'] == ''
                      ? Image.asset(
                        imgProduct,
                        width: 50,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                       controller.snapshotData['imageUrl'],
                    width: 50,
                    fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                          title: boldText(text: "${controller.snapshotData["vendor_name"]}"),
                          subtitle: normalText(text: "${controller.snapshotData['email']}"),
                        ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: List.generate(
                        profileButtonsIcons.length,
                        (index) => ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const ShopSetting());

                                    break;
                                  case 1:
                                    Get.to(() => const MessageScreen());

                                    break;
                                  default:
                                }
                              },
                              leading: Icon(
                                profileButtonsIcons[index],
                                color: white,
                              ),
                              title:
                                  normalText(text: profileButtonsTitles[index]),
                            )),
                  ),
                )
              ],
            );
          }
        },
      ),
    ));
  }
}
