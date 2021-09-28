import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtil{
  /// toast
  static show(String? msg){
    if(msg != null){
      Get.snackbar('', msg, messageText: Text(msg, style: const TextStyle(color: Colors.redAccent, fontSize: 16),), padding: const EdgeInsets.all(2), duration: const Duration(seconds: 1), animationDuration: const Duration(seconds: 1), backgroundColor: Colors.green);
    }
  }
}