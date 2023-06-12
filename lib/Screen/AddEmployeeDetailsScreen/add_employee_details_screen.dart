import 'package:flutter/material.dart';
import 'package:flutter_assignment/networking/bloc/add_employee_bloc.dart';
import 'package:flutter_assignment/networking/bloc/edit_employee_bloc.dart';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:loading_progress/loading_progress.dart';

import '../../networking/Response.dart';
import '../../networking/bloc/delete_employee_bloc.dart';
import '../../utils/date_limit_checker.dart';
import '../../utils/utils.dart';
import '../../utils/loader.dart' as Loader;
class AddEmployeeDetailsScreen extends StatefulWidget {
  const AddEmployeeDetailsScreen({Key? key}) : super(key: key);
  @override
  State<AddEmployeeDetailsScreen> createState() => _AddEmployeeDetailsScreenState();
}

class _AddEmployeeDetailsScreenState extends State<AddEmployeeDetailsScreen> {
  TextEditingController employeeNameController = TextEditingController();
  String? selectedRole;
  late AddEmployeeBloc addEmployeeBloc;
  late EditEmployeeBloc editEmployeeBloc;
  DateTime startCurrentDate = DateTime.now();
  DateTime startCurrentDate2 = DateTime.now();
  String startCurrentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime startTargetDateTime = DateTime.now();

  DateTime endCurrentDate = DateTime.now();
  DateTime endCurrentDate2 = DateTime.now();
  String endCurrentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime endTargetDateTime = DateTime.now();


  DateTime? fromDate = DateTime.now();
  DateTime? endDate;

  late DeleteEmployeeBloc deleteEmployeeBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final arg = ModalRoute.of(context)!.settings.arguments as Map;
      if(arg != null){
        if(arg['isEdit'] == true){
          final employeeData = arg['employeeData'] as AddEmployeeDetailsModel;
          setState(() {
            employeeNameController.text = employeeData.employeeName ?? '';
            selectedRole = employeeData.roleType;
            fromDate = employeeData.fromDate;
            startCurrentDate2 = employeeData.fromDate ?? DateTime.now();
            if(employeeData.isEndDate == true) {
              endDate = employeeData.endDate;
              endCurrentDate2 = employeeData.endDate ?? DateTime.now();
            }
          });
        }
      }
    });
  }


  addEmployeeDetails({
  required AddEmployeeDetailsModel addEmployeeDetailsModel}){
    addEmployeeBloc = AddEmployeeBloc();
    addEmployeeBloc.addEmployeeDetails(reqAddEmployeeDetailsModel: addEmployeeDetailsModel);
    addEmployeeBloc.addEmployeeStream.listen((event) {
      setState(() {
        if(event.status == Status.LOADING){
          LoadingProgress.start(context);
        }else if(event.status == Status.COMPLETED){
          LoadingProgress.stop(context);
          //todo show dialog match user
          Navigator.pop(context);
        }
        else if(event.status == Status.ERROR){
          LoadingProgress.stop(context);
          Loader.showMyDialog(event.message ?? '', context);
        }

      });
    });
  }

  editEmployeeDetails({required int id,
  required AddEmployeeDetailsModel addEmployeeDetailsModel}){
    editEmployeeBloc = EditEmployeeBloc();
    editEmployeeBloc.editEmployeeDetails(id: id,addEmployeeDetailsModel: addEmployeeDetailsModel);
    editEmployeeBloc.editEmployeeStream.listen((event) {
      setState(() {
        if(event.status == Status.LOADING){
          LoadingProgress.start(context);
        }else if(event.status == Status.COMPLETED){
          LoadingProgress.stop(context);
          //todo show dialog match user
          Navigator.pop(context);
        }
        else if(event.status == Status.ERROR){
          LoadingProgress.stop(context);
          Loader.showMyDialog(event.message ?? '', context);
        }

      });
    });
  }


  deleteEmployeeDetails({
    required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel}){
    deleteEmployeeBloc = DeleteEmployeeBloc();
    deleteEmployeeBloc.deleteEmployeeDetails(id: id);
    deleteEmployeeBloc.deleteEmployeeStream.listen((event) {
      setState(() {
        if(event.status == Status.LOADING){
          LoadingProgress.start(context);
        }else if(event.status == Status.COMPLETED){
          LoadingProgress.stop(context);
          //todo show dialog match user
          print("employee id success");
          Navigator.pop(context);
        }
        else if(event.status == Status.ERROR){
          LoadingProgress.stop(context);
          Loader.showMyDialog(event.message ?? '', context);
        }

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: kStatusBarColor,
          // brightness: Brightness.light,
        ),
        body: Column(
          children: [
            Container(
              color: kAppBarBackgroundColor,
              height: 60,
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(arg != null && arg['isEdit'] == true ? "Edit Employee Details" : "Add Employee Details",style: CustomTextStyle.font500FontSize18.copyWith(color: Colors.white),)),
                      Visibility(
                        visible: arg != null && arg['isEdit'] == true,
                          child: InkWell(
                            onTap: (){
                              final argumentEmployeeData = arg['employeeData'] as AddEmployeeDetailsModel;
                              deleteEmployeeDetails(id: argumentEmployeeData.id ?? 0,addEmployeeDetailsModel: argumentEmployeeData);
                            },
                              child: ImageUtil.icons.delete(size: 25.sp)))
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25.sp,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.sp),
                    decoration: BoxDecoration(
                      border: Border.all(color: kInputFieldBorderColor,width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(4))
                    ),
                    height: 50.sp,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageUtil.icons.name(),
                          SizedBox(width: 12.sp,),
                          Expanded(
                            child: TextField(
                              cursorColor: kAppBarBackgroundColor,
                              controller: employeeNameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Employee Name',
                                hintStyle:  CustomTextStyle.font400FontSize16.copyWith(color: kInputFieldPlaceHolderColor),
                              ),
                              style: CustomTextStyle.font400FontSize16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 23.sp,),
                  InkWell(
                    onTap: (){
                      selectRowBottomSheet();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.sp),
                      decoration: BoxDecoration(
                          border: Border.all(color: kInputFieldBorderColor,width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(4))
                      ),
                      height: 50.sp,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageUtil.icons.role(),
                            SizedBox(width: 12.sp,),
                            Expanded(
                              child: Text(selectedRole == null ? "Select Role" : "$selectedRole",style: CustomTextStyle.font400FontSize16.copyWith(color: selectedRole == null ? kInputFieldPlaceHolderColor : Colors.black),),
                            ),
                            SizedBox(width: 12.sp,),
                            ImageUtil.icons.dropdown(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23.sp,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              startDateDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: kInputFieldBorderColor,width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(4))
                              ),
                              height: 50.sp,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageUtil.icons.calender(),
                                    SizedBox(width: 12.sp,),
                                    Expanded(
                                      child: Text(fromDate == null ? "From Date" : DateFormat('dd MMM yyyy').format(fromDate ?? DateTime.now()),style: CustomTextStyle.font400FontSize16.copyWith(color: Colors.black),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.sp,),
                        ImageUtil.icons.next(),
                        SizedBox(width: 15.sp,),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              endDateDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: kInputFieldBorderColor,width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(4))
                              ),
                              height: 50.sp,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageUtil.icons.calender(),
                                    SizedBox(width: 12.sp,),
                                    Expanded(
                                      child: Text(endDate == null ? "No Date" : DateFormat('dd MMM yyyy').format(endDate ?? DateTime.now()),style: CustomTextStyle.font400FontSize16.copyWith(color: Colors.black),),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 20.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Text("Cancel",style: CustomTextStyle.font500FontSize14.copyWith(color: kAppBarBackgroundColor),),
              ),
            ),
            SizedBox(width: 16.sp,),
            InkWell(
              onTap: (){
                    if(employeeNameController.text.isEmpty){
                      Toaster.showMessage(context, msg: 'Please Enter Employee Name');
                    }else if(selectedRole == null){
                      Toaster.showMessage(context, msg: 'Please Select Role');
                    }else if(fromDate == null){
                      Toaster.showMessage(context, msg: 'Please Select From Date');
                    }else if(fromDate != null && endDate != null && DateLimitChecked(startDate: fromDate,endDate: endDate).isInLimit().isCorrectDate == true){
                      Toaster.showMessage(context, msg: '${DateLimitChecked(startDate: fromDate,endDate: endDate).isInLimit().errorMessage}');
                    }
                    else {
                          final arg = ModalRoute.of(context)!.settings.arguments as Map;
                          if(arg != null) {
                            if (arg['isEdit'] == true) {
                              final argumentEmployeeData = arg['employeeData'] as AddEmployeeDetailsModel;
                              AddEmployeeDetailsModel addEmployeeDetailsModel = AddEmployeeDetailsModel(
                                  id: argumentEmployeeData.id,
                                  employeeName: employeeNameController.text,
                                  roleType: selectedRole,
                                  fromDate: startCurrentDate2,
                                  endDate: endCurrentDate2,
                                  isEndDate: endDate == null ? false : true);

                              editEmployeeDetails(id:argumentEmployeeData.id ?? 0,
                                  addEmployeeDetailsModel: addEmployeeDetailsModel);
                            }else{
                              AddEmployeeDetailsModel addEmployeeDetailsModel = AddEmployeeDetailsModel(
                                  employeeName: employeeNameController.text,
                                  roleType: selectedRole,
                                  fromDate: startCurrentDate2,
                                  endDate: endCurrentDate2,
                                  isEndDate: endDate == null ? false : true);
                              addEmployeeDetails(
                                  addEmployeeDetailsModel: addEmployeeDetailsModel);
                            }
                          }
                    }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 20.sp),
                decoration: BoxDecoration(
                  color: kAppBarBackgroundColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text("Save",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),),
              ),
            ),
          ],
        )
    );
  }

  selectRowBottomSheet(){
    final roleArray = ["Product Designer","Flutter Developer","QA Tester","Product Owner"];
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: roleArray.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Center(child: Text(roleArray[index])),onTap: (){
                setState(() {
                  selectedRole = roleArray[index];
                });
                Navigator.pop(context);
            },);
          },
        );
      },
    );
  }

  startDateDialog(){
    // DateTime currentDate = DateTime.now();
    // DateTime currentDate2 = DateTime.now();
    // String currentMonth = DateFormat.yMMM().format(DateTime.now());
    // DateTime targetDateTime = DateTime.now();
    int selectedDateOption = 0;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:(BuildContext context, StateSetter setState){ return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.sp))
                ),
                  height: 80.h,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.sp,horizontal: 16.sp),
                      child: Row(
                        children: [
                          dateSelectionButton(title: 'Today',titleColor: DateFormat("yyyy-MM-dd").format(DateTime.now()) == DateFormat("yyyy-MM-dd").format(startCurrentDate2) ? Colors.white : kAppBarBackgroundColor,backgroundColor: DateFormat("yyyy-MM-dd").format(DateTime.now()) == DateFormat("yyyy-MM-dd").format(startCurrentDate2) ?  kAppBarBackgroundColor : Colors.white,onTap: (){
                            print('Today');
                            setState((){
                              selectedDateOption = 0;
                              fromDate = DateTime.now();
                              startCurrentDate2 = DateTime.now();
                              startTargetDateTime = DateTime(
                                  DateTime.now().year, DateTime.now().month);
                              startCurrentMonth =
                                  DateFormat.yMMM().format(startTargetDateTime);
                            });
                          }),
                          SizedBox(width: 16.sp),
                          dateSelectionButton(title: 'Next Monday',titleColor: DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.monday)) == DateFormat("yyyy-MM-dd").format(startCurrentDate2) ? Colors.white : kAppBarBackgroundColor,backgroundColor:  DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.monday)) == DateFormat("yyyy-MM-dd").format(startCurrentDate2)  ?  kAppBarBackgroundColor : Colors.white,onTap: (){
                            print('Next Monday');
                            setState((){
                              selectedDateOption = 1;
                              startCurrentDate2 = DateTime.now().next(DateTime.monday);
                              startTargetDateTime = DateTime(
                                  DateTime.now().next(DateTime.monday).year, DateTime.now().next(DateTime.monday).month);
                              startCurrentMonth =
                                  DateFormat.yMMM().format(startTargetDateTime);
                            });
                          }),
                          /*Expanded(
                            child: InkWell(
                              onTap: (){
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                decoration: BoxDecoration(
                                    color: kAppBarBackgroundColor,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Center(child: Text("Next Monday",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),)),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Row(
                        children: [
                          dateSelectionButton(title: "Next Tuesday",titleColor: DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.tuesday)) == DateFormat("yyyy-MM-dd").format(startCurrentDate2) ? Colors.white : kAppBarBackgroundColor,backgroundColor: DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.tuesday)) == DateFormat("yyyy-MM-dd").format(startCurrentDate2)?  kAppBarBackgroundColor : Colors.white,onTap: (){
                            setState((){
                              selectedDateOption = 2;
                              startCurrentDate2 = DateTime.now().next(DateTime.tuesday);
                              startTargetDateTime = DateTime(
                                  DateTime.now().next(DateTime.tuesday).year, DateTime.now().next(DateTime.tuesday).month);
                              startCurrentMonth =
                                  DateFormat.yMMM().format(startTargetDateTime);
                            });
                            print('Next Tuesday');
                          }),
                       /*   Expanded(
                            child: InkWell(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                decoration: BoxDecoration(
                                    color: kAppBarBackgroundColor,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Center(child: Text("Next Tuesday",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),)),
                              ),
                            ),
                          ),*/
                          SizedBox(width: 16.sp),
                          dateSelectionButton(title: "After 1 week",titleColor: DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 7))) == DateFormat("yyyy-MM-dd").format(startCurrentDate2) ? Colors.white : kAppBarBackgroundColor,backgroundColor: DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 7))) == DateFormat("yyyy-MM-dd").format(startCurrentDate2) ?  kAppBarBackgroundColor : Colors.white,onTap: (){
                            print('After 1 week');
                            setState((){
                              startCurrentDate2 = DateTime.now().add(const Duration(days: 7));
                              startTargetDateTime = DateTime(
                                  DateTime.now().add(const Duration(days: 7)).year, DateTime.now().add(const Duration(days: 7)).month);
                              startCurrentMonth =
                                  DateFormat.yMMM().format(startTargetDateTime);
                              selectedDateOption = 3;
                            });
                          }),
                          /*Expanded(
                            child: InkWell(
                              onTap: (){
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                decoration: BoxDecoration(
                                    color: kAppBarBackgroundColor,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Center(child: Text("After 1 week",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),)),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 16.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                startTargetDateTime = DateTime(
                                    startTargetDateTime.year, startTargetDateTime.month - 1);
                                startCurrentMonth =
                                    DateFormat.yMMM().format(startTargetDateTime);
                              });
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                              child: ImageUtil.icons.previousMonth(),
                            ),
                          ),
                          Text(startCurrentMonth,style: CustomTextStyle.font500FontSize18.copyWith(color: Color(0xff323238)),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                startTargetDateTime = DateTime(
                                    startTargetDateTime.year, startTargetDateTime.month + 1);
                                startCurrentMonth =
                                    DateFormat.yMMM().format(startTargetDateTime);
                              });
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                              child: ImageUtil.icons.nextMonth(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      // use LayoutBuilder to fetch the parent widget's constraints
                      child: LayoutBuilder(
                      builder: (context, constraints) {
                        var parentHeight = constraints.maxHeight;
                        var parentWidth = constraints.maxWidth;
                        print(parentHeight);
                        return CalendarCarousel<Event>(
                          onCalendarChanged: (DateTime date) {
                            setState(() {
                              startTargetDateTime = date;
                              startCurrentMonth =
                                  DateFormat.yMMM().format(startTargetDateTime);
                            });
                          },
                          onDayPressed: (date, events) {
                            setState(() => startCurrentDate2 = date);
                            events.forEach((event) => print(event.title));
                          },
                          weekendTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
                          headerText: startCurrentMonth,
                          headerTextStyle: TextStyle(
                              color: kAppBarBackgroundColor),
                          weekFormat: false,
                          // markedDatesMap: _markedDateMap,
                          height: parentHeight,
                          width: parentWidth,
                          selectedDateTime: startCurrentDate2,
                          targetDateTime: startTargetDateTime,
                          // showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
                          customGridViewPhysics: const NeverScrollableScrollPhysics(),
                          // markedDateShowIcon: true,
                          // markedDateIconMaxShown: 2,
                          selectedDayTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          todayTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          // markedDateIconBuilder: (event) {
                          //   return event.icon ?? Icon(Icons.help_outline);
                          // },
                          minSelectedDate: DateTime(startCurrentDate.year - 100, startCurrentDate.month , startCurrentDate.day),//_currentDate.subtract(Duration(days: 360)),
                          maxSelectedDate: DateTime(startCurrentDate.year + 100, startCurrentDate.month , startCurrentDate.day),//_currentDate.add(Duration(days: 360)),
                          todayButtonColor: Colors.transparent,
                          // todayBorderColor: Colors.green,
                          markedDateMoreShowTotal: true,
                          // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
                          weekdayTextStyle: TextStyle(color: Colors.black),
                          showOnlyCurrentMonthDate: true,
                          selectedDayButtonColor: kAppBarBackgroundColor,
                          headerMargin: EdgeInsets.zero,
                          showHeader: false,
                        );
                      }))
                    ), //
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 16.sp),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageUtil.icons.calender(),
                                SizedBox(width: 12.sp,),
                                Expanded(
                                  child: Text(DateFormat('dd MMM yyyy').format(startCurrentDate2),style: CustomTextStyle.font400FontSize16.copyWith(color: const Color(0xff323238)),),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 20.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Text("Cancel",style: CustomTextStyle.font500FontSize14.copyWith(color: kAppBarBackgroundColor),),
                                ),
                              ),
                              SizedBox(width: 16.sp,),
                              InkWell(
                                onTap: (){
                                  this.setState((){
                                    fromDate = startCurrentDate2;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 20.sp),
                                  decoration: BoxDecoration(
                                      color: kAppBarBackgroundColor,
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Text("Save",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ) ;});
      },
    );
  }

  Widget dateSelectionButton({Color? backgroundColor,Color? titleColor,String? title,Function()? onTap}) {
    return Expanded(
                          child: InkWell(
                            onTap: onTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
                              decoration: BoxDecoration(
                                  color: backgroundColor ?? kAppBarBackgroundColor,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Center(child: Text(title ?? "Today",style: CustomTextStyle.font500FontSize14.copyWith(color: titleColor ?? Colors.white),)),
                            ),
                          ),
                        );
  }


  endDateDialog(){
    // DateTime _currentDate = DateTime.now();
    // DateTime _currentDate2 = DateTime.now();
    // String _currentMonth = DateFormat.yMMM().format(DateTime.now());
    // DateTime _targetDateTime = DateTime.now();
      int selectedDateOption = 0;

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:(BuildContext context, StateSetter setState){ return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.sp))
                ),
                  height: 80.h,
                child: Column(
                  children: [
                    SizedBox(height: 16.sp,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Row(
                        children: [
                          dateSelectionButton(title:'No Date',titleColor:selectedDateOption == 0 && endDate == null ? Colors.white : kAppBarBackgroundColor,backgroundColor: selectedDateOption == 0 && endDate == null ?  kAppBarBackgroundColor : Colors.white,onTap: (){
                            setState((){
                              selectedDateOption = 0;
                              endDate = null;
                              endCurrentDate2 = DateTime.now();
                            });
                          }),
                          SizedBox(width: 16.sp),
                          dateSelectionButton(title: "Next Monday",titleColor: selectedDateOption == 1 && DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.monday)) == DateFormat("yyyy-MM-dd").format(endCurrentDate2) ? Colors.white : kAppBarBackgroundColor,backgroundColor: selectedDateOption == 1 && DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.monday)) == DateFormat("yyyy-MM-dd").format(endCurrentDate2) ?  kAppBarBackgroundColor : Colors.white,onTap: (){
                            setState((){
                              endCurrentDate2 = DateTime.now().next(DateTime.monday);
                              //endDate = endCurrentDate2;

                              endTargetDateTime = DateTime(
                                  DateTime.now().next(DateTime.monday).year, DateTime.now().next(DateTime.monday).month);
                              endCurrentMonth =
                                  DateFormat.yMMM().format(endTargetDateTime);
                              selectedDateOption = 1;
                            });
                          })
                          // Expanded(
                          //   child: InkWell(
                          //     onTap: (){
                          //     },
                          //     child: Container(
                          //       padding: EdgeInsets.symmetric(vertical: 8.sp),
                          //       decoration: BoxDecoration(
                          //           color: kAppBarBackgroundColor,
                          //           borderRadius: BorderRadius.circular(4)
                          //       ),
                          //       child: Center(child: Text("Next Monday",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),)),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 16.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                endTargetDateTime = DateTime(
                                    endTargetDateTime.year, endTargetDateTime.month - 1);
                                endCurrentMonth =
                                    DateFormat.yMMM().format(endTargetDateTime);
                              });
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                              child: ImageUtil.icons.previousMonth(),
                            ),
                          ),
                          Text(endCurrentMonth,style: CustomTextStyle.font500FontSize18.copyWith(color: Color(0xff323238)),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                endTargetDateTime = DateTime(
                                    endTargetDateTime.year, endTargetDateTime.month + 1);
                                endCurrentMonth =
                                    DateFormat.yMMM().format(endTargetDateTime);
                              });
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                              child: ImageUtil.icons.nextMonth(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      // use LayoutBuilder to fetch the parent widget's constraints
                      child: LayoutBuilder(
                      builder: (context, constraints) {
                        var parentHeight = constraints.maxHeight;
                        var parentWidth = constraints.maxWidth;
                        print(parentHeight);
                        return CalendarCarousel<Event>(
                          onCalendarChanged: (DateTime date) {
                            setState(() {
                              endTargetDateTime = date;
                              endCurrentMonth =
                                  DateFormat.yMMM().format(endTargetDateTime);
                            });
                          },
                          onDayPressed: (date, events) {
                            setState(() {
                              endCurrentDate2 = date;
                              if(endDate == null){
                                selectedDateOption = 0;
                              }
                              if(DateFormat("yyyy-MM-dd").format(DateTime.now().next(DateTime.monday)) == DateFormat("yyyy-MM-dd").format(endCurrentDate2)){
                                selectedDateOption = 1;
                              }else{
                                selectedDateOption = 2;
                              }
                            });

                          },
                          weekendTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
                          headerText: endCurrentMonth,
                          headerTextStyle: TextStyle(
                              color: kAppBarBackgroundColor),
                          weekFormat: false,
                          // markedDatesMap: _markedDateMap,
                          height: parentHeight,
                          width: parentWidth,
                          selectedDateTime: endCurrentDate2,
                          targetDateTime: endTargetDateTime,
                          // showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
                          customGridViewPhysics: const NeverScrollableScrollPhysics(),
                          // markedDateShowIcon: true,
                          // markedDateIconMaxShown: 2,
                          selectedDayTextStyle: TextStyle(
                            color: endDate == null && selectedDateOption == 0 ? kAppBarBackgroundColor :  Colors.white,
                          ),
                          todayTextStyle: TextStyle(
                            color: endDate == null && selectedDateOption == 0 ? kAppBarBackgroundColor : Colors.black,
                          ),
                          // markedDateIconBuilder: (event) {
                          //   return event.icon ?? Icon(Icons.help_outline);
                          // },
                          minSelectedDate: DateTime(endCurrentDate.year - 100, endCurrentDate.month , endCurrentDate.day),//_currentDate.subtract(Duration(days: 360)),
                          maxSelectedDate: DateTime(endCurrentDate.year + 100, endCurrentDate.month , endCurrentDate.day),//_currentDate.add(Duration(days: 360)),
                          todayButtonColor: Colors.transparent,
                          // todayBorderColor: Colors.green,
                          markedDateMoreShowTotal: true,
                          // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
                          weekdayTextStyle: const TextStyle(color: Colors.black),
                          showOnlyCurrentMonthDate: true,
                          selectedDayButtonColor: endDate == null && selectedDateOption == 0 ? Colors.white : kAppBarBackgroundColor,
                          headerMargin: EdgeInsets.zero,
                          showHeader: false,
                        );
                      }))
                    ), //
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 16.sp),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageUtil.icons.calender(),
                                SizedBox(width: 12.sp,),
                                Expanded(
                                  child: Text(selectedDateOption == 0 && endDate == null ? "No Date" : DateFormat('dd MMM yyyy').format(endCurrentDate2),style: CustomTextStyle.font400FontSize16.copyWith(color: const Color(0xff323238)),),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 20.sp),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Text("Cancel",style: CustomTextStyle.font500FontSize14.copyWith(color: kAppBarBackgroundColor),),
                                ),
                              ),
                              SizedBox(width: 16.sp,),
                              InkWell(
                                onTap: (){
                                    this.setState((){
                                      if(selectedDateOption == 0 && endDate == null) {
                                        endDate = null;
                                      }else{
                                        endDate = endCurrentDate2;
                                      }
                                    });
                                    Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 20.sp),
                                  decoration: BoxDecoration(
                                      color: kAppBarBackgroundColor,
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Text("Save",style: CustomTextStyle.font500FontSize14.copyWith(color: Colors.white),),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ) ;});
      },
    );
  }
}


extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}