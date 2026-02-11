import 'package:flutter/material.dart';

mixin UiFeedbackMixin {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context,
    String content,
  ) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(content)));
  }
}
