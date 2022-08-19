import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackbar(String text) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
