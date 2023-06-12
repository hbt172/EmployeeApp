import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class ListHeaderView extends StatelessWidget {
  const ListHeaderView({Key? key,required this.isVisible,required this.title}) : super(key: key);
  final bool isVisible;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Text(title,style: CustomTextStyle.font500FontSize16.copyWith(color: const Color(0xff1DA1F2)),),
        )
    );
  }
}
