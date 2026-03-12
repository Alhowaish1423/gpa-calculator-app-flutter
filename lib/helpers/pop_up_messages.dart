import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void erorrMassage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        alignment: Alignment.center,
        content: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1)),
            child: Text(
              'OK',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      ),
    ),
  );
}

void toastPopUp(BuildContext context, String text) {
  // to delete any older toast
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: text,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      textColor: Theme.of(context).colorScheme.onInverseSurface,
      fontSize: 15,
      toastLength: Toast.LENGTH_SHORT);
     
}
