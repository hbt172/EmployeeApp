part of utils;

const String _iconPath = "assets/images";

class ImageUtil {
  static IconsSVG icons = IconsSVG();
}

class IconsSVG {
  Widget logo({double? width,double? height}) => CustomSvgPictures.asset("$_iconPath/employee_logo.svg",width: width ?? 25.sp,height: height ?? 25.sp);
  Widget calender({double? size}) => Image.asset("$_iconPath/calendar.png",height: size ?? 19.sp, width: size ?? 19.sp);
  Widget plus({double? size}) => Image.asset("$_iconPath/plus.png",height: size ?? 18.sp, width: size ?? 18.sp);
  Widget delete({double? size}) => Image.asset("$_iconPath/delete.png",height: size ?? 18.sp, width: size ?? 18.sp);
  Widget dropdown({double? size}) => Image.asset("$_iconPath/dropdown.png",height: size ?? 6.sp, width: size ?? 11.sp);
  Widget name({double? size}) => Image.asset("$_iconPath/name.png",height: size ?? 15.sp, width: size ?? 15.sp);
  Widget next({double? size}) => Image.asset("$_iconPath/next.png",height: size ?? 9.sp, width: size ?? 13.sp);
  Widget previousMonth({double? size}) => Image.asset("$_iconPath/previous_month.png",height: size ?? 8.sp, width: size ?? 14.sp);
  Widget nextMonth({double? size}) => Image.asset("$_iconPath/next_month.png",height: size ?? 8.sp, width: size ?? 14.sp);
  Widget role({double? width,double? height}) => Image.asset("$_iconPath/role.png",height: height ?? 17.sp, width: width ?? 19.sp);
}

class CustomSvgPictures extends StatelessWidget {
  const CustomSvgPictures.asset(
      this.assetName, {
        Key? key,
        this.width,
        this.height,
        this.fit = BoxFit.cover,
        this.alignment = Alignment.center,
        this.color
      }) : super(key: key);

  final double? width;
  final Color? color;
  final String assetName;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
      color: color,
      placeholderBuilder: (context) {
        return const CommonLoading();
      },
    );
  }
}
