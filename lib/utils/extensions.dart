part of utils;

extension CustomTextStyle on TextStyle {

// font 15
  static TextStyle get font400FontSize15 => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kFont_15
  );

// font 14
  static TextStyle get font400FontSize14 => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kFont_14
  );

  static TextStyle get font500FontSize14 => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: kFont_14
  );


  //font 16
  static TextStyle get font400FontSize16 => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kFont_16
  );

  static TextStyle get font700FontSize16 => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: kFont_16
  );


  static TextStyle get font500FontSize16 => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: kFont_16
  );


  //font 18
  static TextStyle get font500FontSize18 => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: kFont_18
  );

}

extension StringValidator on String{

  bool get isTrimEmpty => trim().isEmpty;

}



extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == weekday) {
      return add(const Duration(days: 7));
    } else {
      return add(
        Duration(
          days: (day - weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }
}
