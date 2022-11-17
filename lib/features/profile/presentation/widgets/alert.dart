import 'package:clean_app_sample/core/material/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertMessage {
  alert(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MyColors.blue,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontFamily: 'Cairo'),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      ),
    );
  }

  loading(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MyColors.blue,
        content: Row(
          children: [CircularProgressIndicator(), Spacer()],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
