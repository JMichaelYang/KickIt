/// Values for use for numbers within the app.
class Values {
  // Animations
  static const Duration animationShort = const Duration(milliseconds: 100);
  static const Duration animationMedium = const Duration(milliseconds: 200);
  static const Duration animationLong = const Duration(milliseconds: 300);

  /// Private constructor so that a [Values] cannot be instantiated from the
  /// outside.
  Values._internal();
}
