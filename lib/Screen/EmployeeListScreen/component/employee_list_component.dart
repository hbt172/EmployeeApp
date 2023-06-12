import 'package:flutter/material.dart';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../utils/utils.dart';

class EmployeeListComponent extends StatelessWidget {
  EmployeeListComponent({Key? key,required this.deleteTap,required this.rowTap,required this.employeeData,required this.strDate}) : super(key: key);
  Function() deleteTap;
  Function() rowTap;
  AddEmployeeDetailsModel employeeData;
  String strDate;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),
      // The end action pane is the one at the right or the bottom side.
      endActionPane:  ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          Builder(builder: (sContext) {
            return Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    Slidable.of(sContext)?.close();
                    deleteTap();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF34642)),
                      child: ImageUtil.icons.delete(size: 25.sp)),
                ),
              ),
            );
          }),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: InkWell(
        onTap: rowTap,
        child: Container(
          color: Colors.white,
          width: 100.w,
          padding: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(employeeData.employeeName ?? '',style: CustomTextStyle.font500FontSize16,),
              SizedBox(height: 5.sp,),
              Text(employeeData.roleType ?? '',style: CustomTextStyle.font400FontSize14.copyWith(color: kTextColor),),
              SizedBox(height: 5.sp,),
              Text(strDate,style: CustomTextStyle.font400FontSize14.copyWith(color: kTextColor)),
            ],
          ),
        ),
      ),
    );
  }
}
