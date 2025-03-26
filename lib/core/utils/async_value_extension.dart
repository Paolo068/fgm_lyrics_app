import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue<void> {
  // show a snackbar on error only
  void showSnackBarOnError(BuildContext context) => whenOrNull(
    error: (error, _) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            behavior: SnackBarBehavior.floating,
            content: Text(error.toString()),
          ),
        );
      });
    },
  );
  // void showToastOnError() => whenOrNull(
  //   error: (error, _) {
  //     Fluttertoast.showToast(
  //       msg: error.toString(),
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 5,
  //       fontSize: 17.0,
  //     );
  //   },
  // );
  
}
