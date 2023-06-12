import 'dart:io';

extension PlatformExt on Platform {

  static String get platformStr {

    return Platform.isIOS ? "iOS" : "Android";

  }

}