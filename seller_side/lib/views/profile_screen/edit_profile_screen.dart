import 'dart:io';

import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_widget.dart';

class EditProfileScreen extends StatefulWidget {

  final String? username;

  const EditProfileScreen({Key? key,this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile,size: 16.0),
          actions: [
           controller.isLoading.value
               ? Padding (
                 padding: const EdgeInsets.all(10),
                 child: loadingIndicator(circleColor: white),
               )
               :  TextButton(
                     onPressed: () async {

                      controller.isLoading(true);

                      if (controller.profileImaPath.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = controller.snapshotData['imageUrl'];
                      }

                      if (controller.snapshotData['password'] == controller.oldPassController.text) {
                        await controller.changeAuthPassword(
                          email: controller.snapshotData['email'],
                          password: controller.newPassController.text,
                          newPassword: controller.newPassController.text,
                        );

                        await controller.uploadProfileImage();
                        await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.newPassController.text,
                          imgUrl: controller.profileImageLink,
                        );
                        VxToast.show(context, msg: "Updated");
                      } else if(

                          controller.oldPassController.text.isEmptyOrNull &&
                          controller.newPassController.text.isEmptyOrNull){

                        await controller.uploadProfileImage();
                        await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.snapshotData['password'],
                            imgUrl:  controller.profileImageLink,
                        );
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Wrong old Password");
                        controller.isLoading(false);
                      }

                  }, child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child:
             Column(
              children: [
                controller.snapshotData['imageUrl'] == '' && controller.profileImaPath.isEmpty
                    ? Image.asset(
                  imgProduct,
                  width: 150,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['imageUrl'] != '' && controller.profileImaPath.isEmpty
                    ? Image.network(
                  controller.snapshotData['imageUrl'],
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.file(
                  File(controller.profileImaPath.value),
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),

                // Image.asset(imgProduct).box.width(150).roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                    onPressed: (){
                    controller.changeImage(context);
                    },
                    child: normalText(
                      text: changeImage,color: fontGrey
                    )),
                10.heightBox,
                const Divider(color: white,),
                10.heightBox,
                customTextField(label: name, hint: "eg.vendor devs",controller: controller.nameController),
                20.heightBox,
                Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change Your Password"),
                ),
                15.heightBox,
                customTextField(label: password, hint: passwordHint,controller: controller.oldPassController),
                10.heightBox,
                customTextField(label: confirmPass, hint: passwordHint,controller: controller.newPassController),
              ],
            ),
        ),
      ),
    );
  }
}
