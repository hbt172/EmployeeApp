import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.onTap, this.isLoading, required this.text, this.isSecondary,this.buttonColor,this.buttonTitleColor, this.padding, this.enabled, this.alignment}) : super(key: key);

  final Function()? onTap;
  final bool? isLoading;
  final bool? enabled;
  final String text;
  final bool? isSecondary;
  final Color? buttonColor;
  final Color? buttonTitleColor;
  final EdgeInsets? padding;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {

    var bgColor = isSecondary == true ? Colors.white : kAppBarBackgroundColor;
    var themeColor = isSecondary == true ? kTextColor : Colors.white;
    var borderColor = isSecondary == true ? kAppBarBackgroundColor : kAppBarBackgroundColor;

    if(enabled == false) {
      bgColor = kDisabledButtonColor;
      themeColor = kDisabledTextColor;
    }

    return InkWell(
      onTap: enabled == false ? null : onTap,
      child: Container(
          padding: padding ?? EdgeInsets.symmetric(vertical: 13.sp, horizontal: 30.sp),
          decoration: BoxDecoration(
            border: enabled == false ? null : Border.all(color: buttonColor ?? borderColor),
              color: buttonColor ?? bgColor,
              borderRadius: BorderRadius.circular(7.sp)
          ),
          alignment: alignment,
          child: isLoading == true ? SizedBox(
            width: 16.sp,
            height: 16.sp,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(buttonTitleColor ?? themeColor),
            ),
          ) : Text(text,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: buttonTitleColor ?? themeColor))
      ),
    );
  }
}

class CustomButtonWithPrefix extends StatelessWidget {
  const CustomButtonWithPrefix({Key? key, this.onTap, this.isLoading, required this.text, this.isSecondary,this.prefixWidget,this.buttonColor,this.buttonTitleColor,this.enabled}) : super(key: key);
  final bool? enabled;
  final Function()? onTap;
  final bool? isLoading;
  final String text;
  final bool? isSecondary;
  final Color? buttonColor;
  final Color? buttonTitleColor;
  final Widget? prefixWidget;
  @override
  Widget build(BuildContext context) {

    var bgColor = isSecondary == true ? Colors.white : kPrimaryColor;
    var themeColor = isSecondary == true ? kTextColor : Colors.white;
    final borderColor = isSecondary == true ? kPrimaryColor : kPrimaryColor;

    if(enabled == false) {
      bgColor = kDisabledButtonColor;
      themeColor = kDisabledTextColor;
    }
    return InkWell(
      onTap: enabled == false ? null : onTap,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 23.sp),
          decoration: BoxDecoration(
              border: enabled == false ? null : Border.all(color: buttonColor ?? borderColor),
              color: buttonColor ?? bgColor,
              borderRadius: BorderRadius.circular(7.sp)
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [

              if(isLoading == true)
                SizedBox(
                  width: 16.sp,
                  height: 16.sp,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        buttonTitleColor ?? themeColor),
                  ),
                ),


              if(isLoading != true)
                Padding(
                  padding: EdgeInsets.only(right: 10.sp),
                  child: prefixWidget ?? const SizedBox.shrink(),
                ),

              if(isLoading != true)
              Text(text,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: buttonTitleColor ?? themeColor)),

            ],
          )
      ),
    );
  }
}
