import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/utils/utils.dart';

class CustomPopup {

  final String? title;
  final TextStyle? titleTextStyle;
  final String message;
  final TextStyle? messageTextStyle;
  final String primaryBtnTxt;
  final String? secondaryBtnTxt;
  final Function? primaryAction;
  final Function? secondaryAction;

  CustomPopup(BuildContext context, {this.title,required this.message,required this.primaryBtnTxt, this.secondaryBtnTxt, this.primaryAction, this.secondaryAction,this.titleTextStyle,this.messageTextStyle}){
    final size = MediaQuery.of(context).size;
    final width = size.width > 500 ? 500 : size.width * 0.8;
    showCupertinoDialog(context: context,
        builder: (context){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 500 ? 500 : size.width * 0.9,minHeight: 100,maxHeight: size.height * 0.7),
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(title != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Center(child: Text(title ?? "",style: titleTextStyle ?? CustomTextStyle.font500FontSize18,)),
                        ),
                      ],
                    ),
                    if(title != null)
                    const SizedBox(height: 10,),
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: size.width > 500 ? 500 : size.width * 0.9,minHeight: 10,maxHeight: size.height * 0.5),
                      child: SingleChildScrollView(
                        child: Text(message,
                          softWrap: true,
                          style: messageTextStyle ?? CustomTextStyle.font500FontSize18,textAlign: TextAlign.center,),
                      )
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(secondaryBtnTxt != null)
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                              if(secondaryAction != null){
                                secondaryAction!();
                              }
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                border: Border.all(color: kAppBarBackgroundColor,width: 1.0),
                                color: kAppBarBackgroundColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                              ),
                              height: 50.sp,
                              width: (width - 80.sp) / 2,
                              child: Center(child: Text(secondaryBtnTxt ?? "",style: CustomTextStyle.font400FontSize16.copyWith(color: Colors.white),)),
                            ),
                          ),
                        if(secondaryBtnTxt != null)
                          const SizedBox(width: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                            if(primaryAction != null){
                              primaryAction!();
                            }
                          },
                          child: Container(
                            decoration:  const BoxDecoration(
                              color: kAppBarBackgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            height: 50.sp,
                            width: (width - 80.sp) / 2,
                            child: Center(child: Text(primaryBtnTxt,style: CustomTextStyle.font400FontSize16.copyWith(color: Colors.white),)),
                          )
                        )
                      ]
                    )
                  ]
                )
              )
            )
          );
        }
    );
  }
}
