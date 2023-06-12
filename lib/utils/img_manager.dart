
part of utils;


extension TextStyleExtension on TextStyle{
  TextStyle override({FontWeight? fontWeight,double? fontSize,String? fontFamily,Color? color,TextDecoration? decoration,double? letterSpacing,FontStyle? fontStyle}) =>
      copyWith(fontFamily: fontFamily,fontSize: fontSize,fontWeight: fontWeight,color: color,decoration: decoration,letterSpacing: letterSpacing,fontStyle: fontStyle);
  TextStyle setFontFamily(String fontFamily) => copyWith(fontFamily: fontFamily);
}