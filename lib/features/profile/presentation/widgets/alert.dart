import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertMessage {
  alert(BuildContext context, String message) {
    return AlertDialog(
      title: Text(
        'Message',
        // style: TextStyle(fontSize: 12),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
