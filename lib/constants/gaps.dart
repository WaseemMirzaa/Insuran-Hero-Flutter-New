import 'package:flutter/cupertino.dart';

class Gaps {
  static double horizontalPadding = 20;
  static double verticalPadding = 20;
}

SizedBox verticalGap(double verticalGap) {
  return SizedBox(
    height: verticalGap,
  );
}
SizedBox horizontalGap(double horizontalalGap) {
  return SizedBox(
    width: horizontalalGap,
  );
}
