// import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talu_bin_driver/apps/views/home_screen.dart';


class HomeController extends GetxController{

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // final isApiCallProcess = false;

  late TextEditingController emailController, passwordController;
  var email = '';
  var password = '';

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }

      //loginFormKey.currentState!.save();
      Get.to(() => HomeScreen());
      emailController.clear();
      passwordController.clear();
    }



  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  }
