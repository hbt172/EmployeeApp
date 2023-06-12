class DateLimitChecked {

  final DateTime? startDate;
  final DateTime? endDate;

  DateLimitChecked({this.startDate, this.endDate});

  DateErrorMessage isInLimit() {
    final startTime = startDate?.millisecondsSinceEpoch;
    final endTime = endDate?.millisecondsSinceEpoch;

    if(startTime == null && endTime == null) return DateErrorMessage(true, 'Please select from date and end date');

    if(startTime == null && endTime != null) {
      return DateErrorMessage(true, 'Please select from date');
    } else if(startTime != null && endTime != null) {
      // return  startTime >= endTime;
      if(startTime >= endTime){
        return DateErrorMessage(true, 'Please select from date must be less than end date');
      }else {
        return DateErrorMessage(false, '');
      }
    } else {
      return  DateErrorMessage(false, '');
    }
  }

}

class DateErrorMessage{
  bool? isCorrectDate;
  String? errorMessage;
  DateErrorMessage(this.isCorrectDate,this.errorMessage);
}