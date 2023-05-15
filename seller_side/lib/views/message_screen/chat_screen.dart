import 'package:emart_seller/views/message_screen/component/chat_bubble.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/text_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
        title: boldText(text: chat,size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder:(context, index) {
                    return chatBubble();
                },)
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: purpleColor,
                            ),
                          ),
                          hintText: "Enter message",
                        ),
                  )),
                  IconButton(onPressed: (){}, icon: Icon(Icons.send,color: purpleColor,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
