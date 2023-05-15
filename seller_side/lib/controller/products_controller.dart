

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../models/category_model.dart';
import 'package:flutter/material.dart';

class ProductsController extends GetxController {

  var isLoading = false.obs;

  var pNameController = TextEditingController();
  var pDescController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  List<Category> category = [];

  var pImagesLinks = [];

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;


  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  popularCategoryList() {
    categoryList.clear();
    for(var item in category){
      categoryList.add(item.name);
    }
  }

  popularSubcategory(cat){
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();

    for(var i = 0; i < data.first.subcategory.length; i++){
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImages(index,context) async {

    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if(img == null){
        return;
      } else{
        pImagesList[index] = File(img.path);
      }
    } catch (e){
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for(var item in pImagesList){
      if(item!=null){
        var filename = basename(item.path);
        var destination = 'images/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProducts(context) async {
    var store = fireStore.collection(productsCollection).doc();
    await store.set({
      'is_feature': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value,Colors.brown.value]),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc':pDescController.text,
      'p_name':pNameController.text,
      'p_price': pPriceController.text,
      'p_quantity': pQuantityController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id':'',
    });
    isLoading(false);
    VxToast.show(context, msg: "Product uploaded Successfully");
  }

  addFeatured(docId) async{
    await fireStore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    },SetOptions(merge: true));
  }
  removeFeatured(docId) async{
    await fireStore.collection(productsCollection).doc(docId).set({
      'featured_id': '',
      'is_featured': false,
    },SetOptions(merge: true));
  }

  removeProducts(docId) async {
    await fireStore.collection(productsCollection).doc(docId).delete();
  }

}
