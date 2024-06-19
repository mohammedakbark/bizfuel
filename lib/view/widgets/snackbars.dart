import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';

class CSnackbar {
  static showErrorToast(context, String title) {
    return CherryToast.error(
      title: Text(title),
    ).show(context);
  }

  static showSuccessToast(context, String title) {
    return CherryToast.success(
      title: Text(title),
    ).show(context);
  }
}
