import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wedgit/dialogs/loading_dialog_widget.dart';

mixin Helper {
// show loading dialog.
  void showLoadingDialog({
    required BuildContext context,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (_) => LoadingDialogWidget(
        title: title,
      ),
      barrierDismissible: false,
    );
  }
}