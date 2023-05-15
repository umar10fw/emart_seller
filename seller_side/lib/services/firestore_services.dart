
// class FireStoreServices {
//
//   static getUser(uid){
//     return fireStore.collection(vendorsCollection).where('id',isEqualTo: uid).snapshots();
//   }
//   static getProducts(category){
//     return fireStore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
//   }
//
//   static getSubCategoryProducts(title){
//     return fireStore.collection(productsCollection).where('p_subcategory',isEqualTo: title).snapshots();
//   }
//
//   static getCart(uid){
//     return fireStore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
//   }
//
//   static deleteDocument(douId){
//     return fireStore.collection(cartCollection).doc(douId).delete();
//   }
//
//   static getChatMessage(docId){
//     return fireStore.collection(chatsCollection)
//         .doc(docId).collection(messagesCollection)
//         .orderBy('created_on', descending: false)
//         .snapshots();
//   }
//
//   static getAllOrders(){
//     return fireStore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
//   }
//
//   static getWishlists(){
//     return fireStore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
//   }
//
//   static getAllMessages(){
//     return fireStore.collection(chatsCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
//   }
//
//   static getCounts() async {
//     var res = await Future.wait([
//       fireStore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
//         return value.docs.length;
//       }),
//       fireStore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
//         return value.docs.length;
//       }),
//       fireStore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value){
//         return value.docs.length;
//       })
//     ]);
//     return res;
//   }
//
//   static allProducts(){
//     return fireStore.collection(productsCollection).snapshots();
//   }
//
//   static getFeaturedProducts(){
//     return fireStore.collection(productsCollection).where('is_featured', isEqualTo: true).get();
//   }
//
//   static searchProducts(title){
//     return fireStore.collection(productsCollection).where('p_name', isLessThanOrEqualTo: title).get();
//   }
//
//
//
// }

import '../const/const.dart';

class StoreServices {
  static getProfile(uid){
    return fireStore.collection(vendorsCollection).where('id',isEqualTo: uid).get();
  }

  static getMessage(uid){
    return fireStore.collection(chatsCollection).where('toId',isEqualTo: uid).snapshots();
  }

  static getOrders(uid){
    return fireStore.collection(ordersCollection).where('vendors',arrayContains: uid).snapshots();
  }

  static getProducts(uid){
    return fireStore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();
  }

  static getPopularProducts(uid) {
    return fireStore.collection(productsCollection).where('vender_id', isEqualTo: uid).orderBy('p_wishlist'.length);
  }


}
