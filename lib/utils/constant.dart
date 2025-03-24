import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todo_app/utils/strings.dart';

dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
      context,
      msg: AppString.oopsMsg,
      subMsg: "You must fill all fields!",
      corner: 20.0,
      duration: 2000,
      padding: const EdgeInsets.all(20)
  );
}

dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
      context,
      msg: AppString.oopsMsg,
      subMsg: "You must edit the tasks then try to update it!",
      corner: 20.0,
      duration: 5000,
      padding: const EdgeInsets.all(20)
  );
}

dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppString.areYouSure,
    message: "Do you really want to delete all tasks? You will no be able to undo this action!",
    confirmButtonText: 'Yes',
    cancelButtonText: 'No',
    onTapConfirm: (){
      Navigator.pop(context);
    },
    onTapCancel: (){
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false
  );
}