import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torment/dialogs/base_dialog.dart';

showDailog_about() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return alertDialogR15(Column(
        children: const [
          Text("TormentApp",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text("Version 1.0.0",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          Text("Copyright © 2022",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          Text("All rights reserved.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          Text("Developed by:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          Text("Egemen Erdem",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Contact:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
          Text("egemenerdem78@gmail.com",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ));
    },
  );
}
