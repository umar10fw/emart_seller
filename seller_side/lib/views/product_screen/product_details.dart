import 'package:get/get.dart';

import '../../const/const.dart';
import '../widgets/text_widget.dart';

class ProductDetails extends StatelessWidget {

  final dynamic data;

  const ProductDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back,color: darkGrey,),
        ),
        title: boldText(text: "${data['p_name']}",color: fontGrey,size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 200,
              aspectRatio: 16 / 9,
              itemCount: data['p_imgs'].length,
              viewportFraction: 1.0,
              itemBuilder:(context, index) {
                return Image.network(data['p_imgs'][index],width: double.infinity,fit: BoxFit.cover);
              },),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "${data['p_name']}", color: fontGrey,size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                  ),
                  10.heightBox,
                  boldText(text: "Rs: ${data['p_price']}",color: red,size: 18.0),
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color",color: fontGrey)
                          ),
                          Row(
                            children: List.generate(
                                1,
                                    (index) => VxBox()
                                        .size(40, 40)
                                        .roundedFull
                                        .color(Color(data['p_colors'][index]))
                                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                                        .make().onTap(() {
                                    })),
                          ),
                        ],
                      ).box.make(),
                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child: boldText(text: "Quantity",color: fontGrey)
                          ),
                          normalText(text: "${data["p_quantity"]}",color: fontGrey),
                        ],
                      ).box.make(),
                    ],
                    ).box.make(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                 normalText(text: "${data['p_desc']}", color: fontGrey),
                  10.heightBox,
                ],
              ),
            ),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
