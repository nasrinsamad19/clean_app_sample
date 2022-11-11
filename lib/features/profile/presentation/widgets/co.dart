import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert {
  void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white, fontFamily: 'Cairo'),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          backgroundColor: Colors.green),
    );
  }
}
