class AddEmployeeDetailsModel {
  int? id;
  String? employeeName;
  String? roleType;
  DateTime? fromDate;
  DateTime? endDate;
  bool? isEndDate;
  DateTime? dateTime;

  AddEmployeeDetailsModel({
    this.id,
    this.employeeName,
    this.roleType,
    this.fromDate,
    this.endDate,
    this.isEndDate,
    this.dateTime
  });

  factory AddEmployeeDetailsModel.fromJson(Map<String, dynamic> json) => AddEmployeeDetailsModel(
    id: json["id"],
    employeeName: json["employeeName"],
    roleType: json["roleType"],
    fromDate: json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    isEndDate: json["isEndDate"],
    dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeName": employeeName,
    "roleType": roleType,
    "fromDate": fromDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "isEndDate": isEndDate,
    "dateTime": dateTime?.toIso8601String()
  };

}