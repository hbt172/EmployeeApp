import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({Key? key, this.color, this.size}) : super(key: key);

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 22,
      width: size ?? 22,
      child: Platform.isIOS ? const CupertinoActivityIndicator(animating: true) : CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? kPrimaryColor),
      ),
    );
  }
}
