import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCustomDialog(BuildContext context, {String title = '', String subtitle = '', Function()? onPressed}) {
  return Platform.isAndroid
      ? showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                onPressed: onPressed ?? () => Navigator.pop(context),
                child: const Text('Ok'),
              )
            ],
          ),
        )
      : showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: onPressed ?? () => Navigator.pop(context),
              )
            ],
          ),
        );
}
