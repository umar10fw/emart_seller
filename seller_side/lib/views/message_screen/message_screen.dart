import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/views/message_screen/chat_screen.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../const/const.dart';
import '../../services/firestore_services.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back,color: darkGrey,),
        ),
        title: boldText(text: message,size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessage(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                   data.length,
                    (index) {
                     var t = data[index]['created_on'] == null
                         ? DateTime.now()
                         : data[index]['created_on'].toDate();
                     var time = intl.DateFormat("h:mma").format(t);
                     return ListTile(
                       onTap: (){
                         Get.to(()=> const ChatScreen());
                       },
                       leading: const CircleAvatar(
                         backgroundColor: purpleColor,
                         child: Icon(Icons.person,color: white,),
                       ),
                       title: boldText(text: "${data[index]['sender_name']}",color: fontGrey),
                       subtitle: normalText(text: "${data[index]['last_msg']}",color: darkGrey),
                       trailing: normalText(text: time,color: darkGrey),
                     );
                    }),
                ),
              ),
            );
          }
        },
      )
    );
  }
}
