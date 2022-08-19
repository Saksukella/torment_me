import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../simple_widgets/snackbar.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton(
      {super.key,
      required this.pressed,
      required this.text,
      required this.color,
      this.padding,
      this.height,
      this.width});

  final Future<bool> Function() pressed;
  final String text;
  final Color color;
  double? width;
  EdgeInsets? padding;
  double? height;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    widget.width ??= Get.width * 0.7;
    widget.height ??= 47;
    widget.padding ??= const EdgeInsets.all(0);
    return Padding(
      padding: widget.padding!,
      child: RoundedLoadingButton(
          controller: _btnController,
          width: widget.width!,
          height: widget.height!,
          color: widget.color,
          elevation: 3,
          borderRadius: 100,
          onPressed: () async {
            isCompleted = await widget.pressed();
            if (isCompleted) {
              _btnController.success();
              showSnackbar("Success");
            } else {
              _btnController.error();
              showSnackbar("Error");
            }
            await Future.delayed(const Duration(seconds: 1), () {
              _btnController.reset();
            });
          },
          child: Text(widget.text)),
    );
  }
}
