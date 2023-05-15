import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:emart_seller/views/order_screen/order_screen.dart';
import 'package:emart_seller/views/product_screen/products_screen.dart';
import 'package:emart_seller/views/profile_screen/profile_screen.dart';
import 'package:emart_seller/views/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navScreen = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];

    var bottomNavbar =  [
      const BottomNavigationBarItem(icon: Icon(Icons.home),label: dashboard),
      BottomNavigationBarItem(icon: Image.asset(icProducts,width: 24,color: darkGrey,),label: products),
      BottomNavigationBarItem(icon: Image.asset(icOrders,width: 24,color: darkGrey,),label: orders),
      BottomNavigationBarItem(icon: Image.asset(icGeneralSetting,width: 24,color: darkGrey,),label: setting),
    ];


    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldText(text: dashboard,color: fontGrey,size: 18.0),
      // ),
      bottomNavigationBar: Obx(
            ()=> BottomNavigationBar(
          onTap: (index){
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          items: bottomNavbar,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        ),
      ),
      body: Obx(
          ()=> Column(
          children: [
            Expanded(
                        child: navScreen.elementAt(controller.navIndex.value)
            ),
          ],
        ),
      ),
    );
  }
}
