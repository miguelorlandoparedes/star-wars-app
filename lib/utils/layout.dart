import 'package:flutter/material.dart';

class LayoutUtils {
  LayoutUtils._();

  static bool isDesktopLayout(BoxConstraints constraints) {
    return constraints.maxWidth >= 900;
  }
}
