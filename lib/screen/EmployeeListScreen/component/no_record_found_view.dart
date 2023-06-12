import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class NoRecordFoundView extends StatelessWidget {
  const NoRecordFoundView({Key? key,required this.isVisible,required this.message}) : super(key: key);
  final bool isVisible;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageUtil.icons.logo(width: 50.w,height: 50.w),
                  Text(message,style: CustomTextStyle.font500FontSize14),
                  const SizedBox(height: 60)
                ]
            )
        )
    );
  }
}
