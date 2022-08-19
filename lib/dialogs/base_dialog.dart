import 'package:flutter/material.dart';

AlertDialog alertDialogR15(Widget content) {
  return AlertDialog(
    content: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(15), child: content)),
  );
}
