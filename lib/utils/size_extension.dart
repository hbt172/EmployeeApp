part of utils;

extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height 812
  double get h => SizerUtil.height == 0.0 ? this * 812 / 100 : this * SizerUtil.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width 375
  double get w => SizerUtil.width == 0.0 ? this * 375 / 100: this * SizerUtil.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  // double get sp => SizerUtil.width == 0.0 ? this * 1.0 : (this * (SizerUtil.width * 0.2666667) / 100);
  double get sp {

    if(SizerUtil.width > 500) {
      return double.parse((this * (500 * 0.2667) / 100).toStringAsFixed(2));
    } else if(SizerUtil.width < 300) {
      return double.parse((this * (300 * 0.2667) / 100).toStringAsFixed(2));
    }

    return SizerUtil.width == 0.0 ? this * 1.0 : double.parse((this * (SizerUtil.width * 0.257) / 100).toStringAsFixed(2));
  }

  double get dp => SizerUtil.width == 0.0 ? this * 1.0 : (this * (SizerUtil.width * 0.267) / 100);
}