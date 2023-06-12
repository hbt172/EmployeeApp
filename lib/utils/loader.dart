import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/utils/utils.dart';

/// show message dialog
Future<void> showMyDialog(String msg, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title:  Text(
          'Alert',
          style: CustomTextStyle.font500FontSize18 ,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                msg,
                style: CustomTextStyle.font500FontSize18,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  color: kAppBarBackgroundColor,
                ),
                child: Center(
                  child: Text(
                      'OK',
                      style: CustomTextStyle.font500FontSize18,
                    ),
                ),

                ),
            ),
            ),
        ],
      );
    },
  );
}
