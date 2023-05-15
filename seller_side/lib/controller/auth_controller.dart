import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../const/const.dart';

class AuthController extends GetxController {
  // Text Field Controller

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  // LogIn Method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
