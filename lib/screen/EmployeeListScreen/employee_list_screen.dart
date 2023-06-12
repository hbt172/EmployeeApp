import 'package:flutter/material.dart';
import 'package:flutter_assignment/Screen/EmployeeListScreen/component/employee_list_component.dart';
import 'package:flutter_assignment/Screen/EmployeeListScreen/component/list_header_view.dart';
import 'package:flutter_assignment/Screen/EmployeeListScreen/component/no_record_found_view.dart';
import 'package:flutter_assignment/networking/bloc/delete_employee_bloc.dart';
import 'package:flutter_assignment/networking/bloc/get_employee_bloc.dart';
import 'package:flutter_assignment/networking/model/request/add_employee_details/req_add_employee_details.dart';
import 'package:intl/intl.dart';
import 'package:loading_progress/loading_progress.dart';
import '../../app/home/route/lending_route.dart';
import '../../networking/Response.dart';
import '../../utils/utils.dart';
import '../../utils/loader.dart' as loader;
class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late GetEmployeeBloc addEmployeeBloc;
  List<AddEmployeeDetailsModel> employeeList = [];
  List<AddEmployeeDetailsModel> currentEmployeesList = [];
  List<AddEmployeeDetailsModel> previousEmployeesList = [];
  late DeleteEmployeeBloc deleteEmployeeBloc;
  bool isUndoDelete = false;
  AddEmployeeDetailsModel deleteEmployeeData = AddEmployeeDetailsModel();
  int deleteIndexValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeList();
  }


  getEmployeeList(){
    // TODO: implement getEmployeeList
    addEmployeeBloc = GetEmployeeBloc();
    addEmployeeBloc.getEmployeeDetails();
    addEmployeeBloc.getEmployeeStream.listen((event) {
      setState(() {
        if(event.status == Status.LOADING){
          LoadingProgress.start(context);
        }else if(event.status == Status.COMPLETED){
          LoadingProgress.stop(context);
          //todo show dialog match user
          employeeList = event.data ?? [];
          previousEmployeesList = [];
          currentEmployeesList = [];
          if(employeeList.isNotEmpty){
            for (var element in employeeList) {
              final currentDate = DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));
              final endDate = DateTime.parse(DateFormat("yyyy-MM-dd").format(element.endDate ?? DateTime.now()));
              if(element.isEndDate == true && endDate.compareTo(currentDate) < 0){
                previousEmployeesList.add(element);
              }
              else{
                currentEmployeesList.add(element);
              }
            }
          }
        }
        else if(event.status == Status.ERROR){
          LoadingProgress.stop(context);
          loader.showMyDialog(event.message ?? '', context);
        }

      });
    });
  }


  deleteEmployeeDetails({
    required int id,required AddEmployeeDetailsModel addEmployeeDetailsModel,required int deleteIndex}){
    // TODO: implement deleteEmployeeDetails
    deleteEmployeeBloc = DeleteEmployeeBloc();
    deleteEmployeeBloc.deleteEmployeeDetails(id: id);
    deleteEmployeeBloc.deleteEmployeeStream.listen((event) {
      setState(() {
        if(event.status == Status.LOADING){
          LoadingProgress.start(context);
        }else if(event.status == Status.COMPLETED){
          LoadingProgress.stop(context);
          //todo show dialog match user
          getEmployeeList();
        }
        else if(event.status == Status.ERROR){
          LoadingProgress.stop(context);
          loader.showMyDialog(event.message ?? '', context);
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: kStatusBarColor
        ),
        body: Builder(
            builder: (BuildContext ctx) {
              return Column(
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
                      Text("Employee List",style: CustomTextStyle.font500FontSize18.copyWith(color: Colors.white),),
                    ],
                  ),
                ),
                NoRecordFoundView(isVisible: previousEmployeesList.isEmpty && currentEmployeesList.isEmpty,message: "No employee records found"),
                Visibility(
                  visible: previousEmployeesList.isNotEmpty || currentEmployeesList.isNotEmpty,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListHeaderView(title: 'Current employees',isVisible: currentEmployeesList.isNotEmpty),
                          Visibility(
                            visible: currentEmployeesList.isNotEmpty,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:currentEmployeesList.isEmpty ? 0 : currentEmployeesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final employeeData = currentEmployeesList[index];
                                  var strDate = '';
                                  if(employeeData.isEndDate == false) {
                                    strDate =  'From ${DateFormat('dd MMM,yyyy').format(employeeData.fromDate ?? DateTime.now())}';
                                  }else{
                                    strDate = '${DateFormat('dd MMM, yyyy').format(employeeData.fromDate ?? DateTime.now())} - ${DateFormat('dd MMM, yyyy').format(employeeData.endDate ?? DateTime.now())}';
                                  }
                                  return EmployeeListComponent(deleteTap:() {
                                      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                                      int second = 3;
                                      isUndoDelete = false;
                                      deleteEmployeeData = employeeData;
                                      deleteIndexValue = index;
                                      currentEmployeesList.removeAt(index);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            behavior: SnackBarBehavior.fixed,
                                            content: Row(
                                              children: [
                                                const Expanded(child: Text('Employee data has been deleted')),
                                                InkWell(
                                                    onTap: (){
                                                      isUndoDelete = true;
                                                      currentEmployeesList.insert(deleteIndexValue, deleteEmployeeData);
                                                      setState(() {
                                                      });
                                                      ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                                                    },
                                                    child: Text('Undo',style: CustomTextStyle.font400FontSize15.copyWith(color: const Color(0xff1DA1F2)),))
                                              ],
                                            ),
                                            duration:  Duration(seconds: second),
                                          ));
                                      setState(() {
                                      });
                                      Future.delayed(Duration(seconds: second)).then((val) {
                                        // Your logic here
                                        if(isUndoDelete == false) {
                                          deleteEmployeeDetails(
                                              id: employeeData.id ?? 0,
                                              addEmployeeDetailsModel: employeeData,
                                              deleteIndex: deleteIndexValue);
                                        }
                                      });

                                    }
                                  , rowTap: (){
                                        Navigator.of(context).pushNamed(HomeRouting.addEmployeeDetailsScreenRoute,arguments: {'isEdit':true,
                                          'employeeData':employeeData}).then((value) {
                                          getEmployeeList();
                                        });
                                  }, employeeData: employeeData, strDate: strDate);
                                }),
                          ),
                          ListHeaderView(title: 'Previous employees',isVisible: previousEmployeesList.isNotEmpty),
                          Visibility(
                            visible: previousEmployeesList.isNotEmpty,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:previousEmployeesList.isEmpty ? 0 : previousEmployeesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final employeeData = previousEmployeesList[index];
                                  var strDate = '';
                                  if(employeeData.isEndDate == false) {
                                    strDate =  'From ${DateFormat('dd MMM,yyyy').format(employeeData.fromDate ?? DateTime.now())}';
                                  }else{
                                    strDate = '${DateFormat('dd MMM, yyyy').format(employeeData.fromDate ?? DateTime.now())} - ${DateFormat('dd MMM, yyyy').format(employeeData.endDate ?? DateTime.now())}';
                                  }

                                  return EmployeeListComponent(deleteTap:() {
                                    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                                    int second = 3;
                                    isUndoDelete = false;
                                    deleteEmployeeData = employeeData;
                                    deleteIndexValue = index;
                                    previousEmployeesList.removeAt(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.fixed,
                                          content: Row(
                                            children: [
                                              const Expanded(child: Text('Employee data has been deleted')),
                                              InkWell(
                                                  onTap: (){
                                                    isUndoDelete = true;
                                                    previousEmployeesList.insert(deleteIndexValue, deleteEmployeeData);
                                                    setState(() {
                                                    });
                                                    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
                                                  },
                                                  child: Text('Undo',style: CustomTextStyle.font400FontSize15.copyWith(color: const Color(0xff1DA1F2)),))
                                            ],
                                          ),
                                          duration:  Duration(seconds: second),
                                        ));

                                    setState(() {
                                    });
                                    Future.delayed(Duration(seconds: second)).then((val) {
                                      if(isUndoDelete == false) {
                                        deleteEmployeeDetails(
                                            id: employeeData.id ?? 0,
                                            addEmployeeDetailsModel: employeeData,
                                            deleteIndex: deleteIndexValue);
                                      }
                                    });
                                  }
                                      , rowTap: (){
                                        Navigator.of(context).pushNamed(HomeRouting.addEmployeeDetailsScreenRoute,arguments: {'isEdit':true,
                                          'employeeData':employeeData}).then((value) {
                                          getEmployeeList();
                                        });
                                      }, employeeData: employeeData, strDate: strDate);

                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );}),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(HomeRouting.addEmployeeDetailsScreenRoute,arguments: {'isEdit':false}).then((value) {
              getEmployeeList();
            });
          },
          backgroundColor: kAppBarBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ImageUtil.icons.plus(),
        )
    );
  }
}

